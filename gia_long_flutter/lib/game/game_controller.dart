import 'package:flutter/foundation.dart';

import '../models/base_building.dart';
import '../models/battle.dart';
import '../models/player_state.dart';
import '../models/scene.dart';
import '../services/save_service.dart';
import '../story/story_registry.dart';

/// Điều phối luồng game: chuyển cảnh, áp dụng hiệu ứng, nhiệm vụ, lưu tiến trình.
class GameController extends ChangeNotifier {
  GameController._(this._save, this.state);

  /// Bắt đầu ván mới (ghi đè bản lưu cũ).
  factory GameController.newGame(SaveService save) {
    final controller = GameController._(save, PlayerState.newGame());
    controller._enterScene(startSceneId);
    controller._persist();
    return controller;
  }

  /// Tiếp tục từ bản lưu; nếu cảnh đã lưu không còn tồn tại thì quay về checkpoint.
  factory GameController.resume(SaveService save, PlayerState saved) {
    var state = saved;
    if (!sceneById.containsKey(state.sceneId)) {
      final cp = state.checkpoint;
      state = cp != null ? PlayerState.fromSnapshot(cp) : PlayerState.newGame();
      state.checkpoint = cp;
    }
    final controller = GameController._(save, state);
    if (!sceneById.containsKey(state.sceneId)) controller._enterScene(startSceneId);
    return controller;
  }

  final SaveService _save;
  PlayerState state;
  final List<String> _notices = [];

  Scene get scene => sceneById[state.sceneId]!;

  /// Các thông báo (chỉ số, nhiệm vụ...) phát sinh kể từ lần gọi trước.
  List<String> takeNotices() {
    final out = List<String>.of(_notices);
    _notices.clear();
    return out;
  }

  // --- Lựa chọn ---

  bool isVisible(Choice c) => c.excludeFlag == null || !state.flags.contains(c.excludeFlag);

  bool isUnlocked(Choice c) =>
      state.meets(c.requires) && (c.requiresFlag == null || state.flags.contains(c.requiresFlag));

  /// Lý do bị khóa, hoặc `null` nếu chọn được.
  String? lockedReason(Choice c) {
    if (isUnlocked(c)) return null;
    final missing = c.requires.entries.where((e) => state.stat(e.key) < e.value);
    final parts = [
      for (final e in missing) '${PlayerState.statLabels[e.key] ?? e.key} ≥ ${e.value}',
      if (c.requiresFlag != null && !state.flags.contains(c.requiresFlag)) 'điều kiện đặc biệt',
    ];
    return 'Cần ${parts.join(', ')}';
  }

  List<Choice> get visibleChoices => scene.choices.where(isVisible).toList();

  void choose(Choice c) {
    if (!isVisible(c) || !isUnlocked(c)) return;
    _applyEffect(c.effect);
    state.flags.addAll(c.setFlags);
    c.startQuests.forEach(_startQuest);
    c.completeQuests.forEach(_completeQuest);
    if (c.logLabel != null) state.choiceLog.add(c.logLabel!);
    goTo(c.next);
  }

  // --- Chuyển cảnh ---

  void goTo(String next) {
    if (next == menuToken) return; // màn hình tự xử lý
    if (next == checkpointToken) {
      restoreCheckpoint();
      return;
    }
    _enterScene(next);
    _finishTransition();
  }

  /// Quay lại đầu Hồi hiện tại.
  void restoreCheckpoint() {
    final cp = state.checkpoint;
    if (cp == null) return;
    state = PlayerState.fromSnapshot(cp)..checkpoint = cp;
    _enterScene(state.sceneId);
    _notices.add('Đã quay lại đầu Hồi.');
    _finishTransition();
  }

  void _enterScene(String id) {
    final s = sceneById[id];
    if (s == null) throw StateError('Không tìm thấy cảnh "$id"');
    state.sceneId = id;
    if (s.checkpoint) state.checkpoint = state.snapshot();
    _applyEffect(s.onEnterEffect);
    state.flags.addAll(s.setFlags);
    s.startQuests.forEach(_startQuest);
    s.completeQuests.forEach(_completeQuest);
  }

  void _finishTransition() {
    _persist();
    notifyListeners();
  }

  // --- Chiến đấu & căn cứ ---

  bool isWeakened(BattleDef def) => def.weakenFlags.any(state.flags.contains);

  void finishBattle(BattleDef def, BattleResult result) {
    // Thiệt hại binh lính và tinh thần đã tiêu hao trong trận.
    _applyEffect({
      if (result.damageTaken ~/ 8 > 0) 'army': -(result.damageTaken ~/ 8),
      if (result.moraleSpent > 0) 'morale': -result.moraleSpent,
    });
    _notices.add(result.won ? def.winText : def.loseText);
    if (result.won) {
      _applyEffect(def.winEffect);
      def.winCompleteQuests.forEach(_completeQuest);
      goTo(def.winNext);
    } else {
      goTo(def.loseNext);
    }
  }

  /// [finalStats] là chỉ số sau khi người chơi phân bổ xong các mùa vụ.
  void finishBase(BaseDef def, Map<String, int> finalStats) {
    state.stats.addAll(finalStats);
    for (final goal in def.goals) {
      if (state.meets(goal.requires)) {
        _completeQuest(goal.questId);
      } else {
        _notices.add('Chưa đạt mục tiêu: ${goal.description}');
      }
    }
    goTo(def.next);
  }

  // --- Nhiệm vụ & chỉ số ---

  void _applyEffect(Map<String, int> effect) {
    if (effect.isEmpty) return;
    state.applyEffect(effect);
    _notices.add(PlayerState.describeEffect(effect));
  }

  void _startQuest(String id) {
    if (state.completedQuests.contains(id) || !state.activeQuests.add(id)) return;
    _notices.add('Nhiệm vụ mới: ${questsById[id]?.title ?? id}');
  }

  void _completeQuest(String id) {
    if (!state.completedQuests.add(id)) return;
    state.activeQuests.remove(id);
    final quest = questsById[id];
    _notices.add('Hoàn thành: ${quest?.title ?? id}');
    if (quest != null) _applyEffect(quest.rewardEffect);
  }

  void _persist() {
    _save.save(state).catchError((Object e) => debugPrint('Lỗi lưu game: $e'));
  }
}
