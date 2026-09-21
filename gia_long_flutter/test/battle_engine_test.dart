import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/game/battle_engine.dart';
import 'package:gia_long_flutter/models/battle.dart';
import 'package:gia_long_flutter/story/story_registry.dart';

/// Người chơi biết đọc dấu hiệu của địch: né đòn mạnh, tận dụng lúc địch sơ hở.
PlayerAction smartPolicy(BattleEngine e) => switch (e.nextMove) {
      EnemyMove.heavy => PlayerAction.defend,
      EnemyMove.defend => e.canUseSkill ? PlayerAction.skill : PlayerAction.attack,
      EnemyMove.attack || EnemyMove.rally => PlayerAction.attack,
    };

BattleEngine run(BattleDef def, PlayerAction Function(BattleEngine) policy,
    {int army = 10, int food = 30, int morale = 30, bool weakened = false}) {
  final e = BattleEngine(def: def, army: army, food: food, morale: morale, weakened: weakened);
  while (!e.finished) {
    e.act(policy(e));
  }
  return e;
}

void main() {
  const scripted = ['b_rachgam'];

  // Trận cuối đòi hỏi chuẩn bị (quân lực ≥ 30, mục tiêu căn cứ Hồi 4).
  const armyNeeded = {'b_thanglong': 30};

  for (final def in allBattles.where((b) => !scripted.contains(b.id))) {
    test('${def.id}: chơi khôn với chỉ số tối thiểu vẫn thắng được', () {
      final e = run(def, smartPolicy, army: armyNeeded[def.id] ?? 10);
      expect(e.won, isTrue);
    });

    test('${def.id}: chỉ phòng thủ thì không thể thắng', () {
      expect(run(def, (_) => PlayerAction.defend).won, isFalse);
    });
  }

  test('b_thanglong: bỏ bê quân lực (10) thì thua', () {
    expect(run(battlesById['b_thanglong']!, smartPolicy).won, isFalse);
  });

  test('b_rachgam: thất bại có kịch bản dù chơi thế nào', () {
    final def = battlesById['b_rachgam']!;
    final e = run(def, smartPolicy, army: 100, food: 100, morale: 100);
    expect(e.won, isFalse);
    expect(e.turn, lessThanOrEqualTo(def.scriptedDefeatTurn!));
  });

  test('địch suy yếu có ít máu hơn 20%', () {
    final def = battlesById['b_quynhon']!;
    final normal = BattleEngine(def: def, army: 10, food: 30, morale: 30);
    final weak = BattleEngine(def: def, army: 10, food: 30, morale: 30, weakened: true);
    expect(weak.enemyMaxHp, (normal.enemyMaxHp * 0.8).round());
  });

  test('kỹ năng tốn tinh thần và bị khóa khi không đủ', () {
    final def = battlesById['b_quynhon']!;
    final e = BattleEngine(def: def, army: 10, food: 30, morale: 10);
    e.act(PlayerAction.skill);
    expect(e.morale, 0);
    expect(e.moraleSpent, BattleEngine.skillCost);
    final turn = e.turn;
    e.act(PlayerAction.skill); // không đủ tinh thần → bỏ qua
    expect(e.turn, turn);
  });
}
