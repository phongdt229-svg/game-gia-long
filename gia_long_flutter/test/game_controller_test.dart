import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/game/battle_engine.dart';
import 'package:gia_long_flutter/game/game_controller.dart';
import 'package:gia_long_flutter/models/player_state.dart';
import 'package:gia_long_flutter/models/scene.dart';
import 'package:gia_long_flutter/services/save_service.dart';
import 'package:gia_long_flutter/story/story_registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'battle_engine_test.dart' show smartPolicy;

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('ván mới bắt đầu ở Hồi 1, mở quest và lưu checkpoint', () {
    final c = GameController.newGame(SaveService());
    expect(c.scene.id, startSceneId);
    expect(c.state.activeQuests, contains('Q1_GiaDinh'));
    expect(c.state.checkpoint, isNotNull);
  });

  test('lựa chọn áp dụng chỉ số, flag, nhật ký và chuyển cảnh', () {
    final c = GameController.newGame(SaveService());
    final choice = c.scene.choices.firstWhere((x) => x.next == 'a1_granary');
    c.choose(choice);
    expect(c.scene.id, 'a1_granary');
    expect(c.state.flags, contains('nhan_tu'));
    expect(c.state.stat('food'), 50 - 10);
    expect(c.state.stat('morale'), 50 + 15);
    expect(c.state.choiceLog, isNotEmpty);
    expect(c.takeNotices(), isNotEmpty);
    expect(c.takeNotices(), isEmpty);
  });

  test('lựa chọn bị khóa không chọn được và có lý do', () {
    final c = GameController.newGame(SaveService());
    c.state.sceneId = 'a4_start';
    final locked = c.scene.choices.firstWhere((x) => x.requires.isNotEmpty);
    expect(c.lockedReason(locked), contains('Ngoại giao'));
    c.choose(locked);
    expect(c.scene.id, 'a4_start');
  });

  test('lưu rồi tải lại giữ nguyên trạng thái', () async {
    final save = SaveService();
    final c = GameController.newGame(save);
    c.choose(c.scene.choices.first);
    await Future<void>.delayed(Duration.zero);
    final loaded = await save.load();
    expect(loaded, isNotNull);
    expect(loaded!.sceneId, c.state.sceneId);
    expect(loaded.stats, c.state.stats);
    final resumed = GameController.resume(save, loaded);
    expect(resumed.scene.id, c.scene.id);
  });

  test('quay lại checkpoint khôi phục đầu Hồi', () {
    final c = GameController.newGame(SaveService());
    c.choose(c.scene.choices.firstWhere((x) => x.next == 'a1_granary'));
    c.restoreCheckpoint();
    expect(c.scene.id, startSceneId);
    expect(c.state.flags, isNot(contains('nhan_tu')));
    expect(c.state.stat('food'), 50);
  });

  test('bản lưu trỏ tới cảnh không còn tồn tại thì quay về checkpoint/đầu game', () {
    final saved = PlayerState.newGame()..sceneId = 'khong_ton_tai';
    final c = GameController.resume(SaveService(), saved);
    expect(c.scene.id, startSceneId);
  });

  test('chơi ngẫu nhiên nhiều lần luôn tới được cảnh kết thúc', () {
    for (var seed = 0; seed < 300; seed++) {
      final rng = Random(seed);
      final c = GameController.newGame(SaveService());
      var steps = 0;
      while (c.scene.type != SceneType.ending) {
        expect(++steps, lessThan(500), reason: 'seed $seed kẹt ở ${c.scene.id}');
        final scene = c.scene;
        switch (scene.type) {
          case SceneType.story:
            final open = c.visibleChoices.where(c.isUnlocked).toList();
            expect(open, isNotEmpty, reason: 'seed $seed: ngõ cụt ở ${scene.id}');
            c.choose(open[rng.nextInt(open.length)]);
          case SceneType.battle:
            final def = battlesById[scene.battleId]!;
            final e = BattleEngine(
              def: def,
              army: c.state.stat('army'),
              food: c.state.stat('food'),
              morale: c.state.stat('morale'),
              weakened: c.isWeakened(def),
            );
            while (!e.finished) {
              e.act(rng.nextDouble() < 0.8 ? smartPolicy(e) : PlayerAction.values[rng.nextInt(3)]);
            }
            c.finishBattle(def, e.result);
          case SceneType.base:
            final def = basesById[scene.baseId]!;
            final work = PlayerState.fromJson(c.state.toJson());
            for (var i = 0; i < def.turns; i++) {
              final open = def.actions
                  .where((a) => a.requiresFlag == null || work.flags.contains(a.requiresFlag))
                  .toList();
              work.applyEffect(open[rng.nextInt(open.length)].effect);
            }
            c.finishBase(def, work.stats);
          case SceneType.ending:
            break;
        }
      }
    }
  });

  test('căn cứ Hồi 4: có cách phân bổ đạt cả hai mục tiêu từ chỉ số ban đầu', () {
    final def = basesById['base_giadinh']!;
    bool search(PlayerState s, int turnsLeft) {
      if (def.goals.every((g) => s.meets(g.requires))) return true;
      if (turnsLeft == 0) return false;
      for (final a in def.actions.where((a) => a.requiresFlag == null)) {
        final next = PlayerState.fromJson(s.toJson())..applyEffect(a.effect);
        if (search(next, turnsLeft - 1)) return true;
      }
      return false;
    }

    expect(search(PlayerState.newGame(), def.turns), isTrue);
  });
}
