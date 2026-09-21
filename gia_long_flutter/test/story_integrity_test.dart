import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/models/scene.dart';
import 'package:gia_long_flutter/models/player_state.dart';
import 'package:gia_long_flutter/story/story_registry.dart';

/// Kiểm tra dữ liệu story không có liên kết gãy / ngõ cụt.
void main() {
  test('id cảnh là duy nhất', () {
    expect(sceneById.length, allScenes.length);
  });

  test('cảnh bắt đầu tồn tại', () {
    expect(sceneById.containsKey(startSceneId), isTrue);
  });

  test('mọi liên kết cảnh/quest/battle/base đều hợp lệ', () {
    final problems = <String>[];
    void checkQuests(String where, List<String> ids) {
      for (final id in ids) {
        if (!questsById.containsKey(id)) problems.add('$where: quest "$id" không tồn tại');
      }
    }

    for (final s in allScenes) {
      checkQuests(s.id, [...s.startQuests, ...s.completeQuests]);
      switch (s.type) {
        case SceneType.battle:
          if (!battlesById.containsKey(s.battleId)) problems.add('${s.id}: battle ${s.battleId}');
        case SceneType.base:
          if (!basesById.containsKey(s.baseId)) problems.add('${s.id}: base ${s.baseId}');
        case SceneType.story:
          if (s.choices.isEmpty) problems.add('${s.id}: cảnh truyện không có lựa chọn');
        case SceneType.ending:
          break;
      }
      for (final c in s.choices) {
        if (!isSpecialTarget(c.next) && !sceneById.containsKey(c.next)) {
          problems.add('${s.id}: next "${c.next}" không tồn tại');
        }
        checkQuests(s.id, [...c.startQuests, ...c.completeQuests]);
      }
    }
    for (final b in allBattles) {
      for (final next in [b.winNext, b.loseNext]) {
        if (!sceneById.containsKey(next)) problems.add('${b.id}: next "$next" không tồn tại');
      }
      checkQuests(b.id, b.winCompleteQuests);
    }
    for (final b in allBases) {
      if (!sceneById.containsKey(b.next)) problems.add('${b.id}: next "${b.next}" không tồn tại');
      checkQuests(b.id, b.goals.map((g) => g.questId).toList());
      for (final key in [...b.actions.expand((a) => a.effect.keys)]) {
        if (!PlayerState.statKeys.contains(key)) problems.add('${b.id}: chỉ số lạ "$key"');
      }
    }
    expect(problems, isEmpty);
  });

  test('mọi cảnh truyện đều có ít nhất một lựa chọn luôn chọn được', () {
    final stuck = [
      for (final s in allScenes)
        if (s.type == SceneType.story &&
            !s.choices.any((c) =>
                c.requires.isEmpty && c.requiresFlag == null && c.excludeFlag == null))
          s.id,
    ];
    expect(stuck, isEmpty);
  });

  test('mọi cảnh đều tới được từ cảnh bắt đầu', () {
    final seen = <String>{};
    final queue = [startSceneId];
    while (queue.isNotEmpty) {
      final id = queue.removeLast();
      if (!seen.add(id)) continue;
      final s = sceneById[id]!;
      queue.addAll(s.choices.map((c) => c.next).where((n) => !isSpecialTarget(n)));
      if (s.battleId != null) {
        final b = battlesById[s.battleId]!;
        queue.addAll([b.winNext, b.loseNext]);
      }
      if (s.baseId != null) queue.add(basesById[s.baseId]!.next);
    }
    final unreachable = sceneById.keys.toSet().difference(seen);
    expect(unreachable, isEmpty);
  });

  test('quest được mở thì có chỗ hoàn thành (trừ nhiệm vụ không bắt buộc)', () {
    final started = <String>{};
    final completed = <String>{};
    for (final s in allScenes) {
      started.addAll(s.startQuests);
      completed.addAll(s.completeQuests);
      for (final c in s.choices) {
        started.addAll(c.startQuests);
        completed.addAll(c.completeQuests);
      }
    }
    for (final b in allBattles) {
      completed.addAll(b.winCompleteQuests);
    }
    for (final b in allBases) {
      completed.addAll(b.goals.map((g) => g.questId));
    }
    expect(started.difference(completed), isEmpty);
  });

  test('mọi flag được yêu cầu đều có nơi đặt', () {
    final set = <String>{};
    final required = <String>{};
    for (final s in allScenes) {
      set.addAll(s.setFlags);
      for (final c in s.choices) {
        set.addAll(c.setFlags);
        if (c.requiresFlag != null) required.add(c.requiresFlag!);
        if (c.excludeFlag != null) required.add(c.excludeFlag!);
      }
    }
    for (final b in allBattles) {
      required.addAll(b.weakenFlags);
    }
    for (final b in allBases) {
      required.addAll(b.actions.map((a) => a.requiresFlag).whereType<String>());
    }
    expect(required.difference(set), isEmpty);
  });
}
