import 'dart:math' as math;

import '../models/battle.dart';

enum PlayerAction { attack, defend, skill }

/// Logic chiến đấu theo lượt, tách khỏi UI để dễ kiểm thử.
///
/// Mỗi lượt địch "báo trước" nước đi kế tiếp ([nextMove]); người chơi chọn
/// Tấn công / Phòng thủ / Dùng kỹ năng rồi hai bên lần lượt ra đòn.
class BattleEngine {
  BattleEngine({
    required this.def,
    required int army,
    required int food,
    required this.morale,
    this.weakened = false,
  })  : playerMaxHp = 60 + army + food ~/ 5,
        playerAtk = 10 + army ~/ 5 {
    playerHp = playerMaxHp;
    log.add(def.intro);
    _startPhase(0);
  }

  static const skillCost = 10;
  static const maxTurns = 30;
  static const defendReduction = 0.4; // còn lại 40% sát thương khi phòng thủ

  final BattleDef def;

  /// Địch yếu đi (máu -20%) nhờ các quyết định trước đó.
  final bool weakened;
  final int playerMaxHp;
  final int playerAtk;
  late int playerHp;
  int morale;
  int moraleSpent = 0;
  int damageTaken = 0;
  int turn = 0;
  int phaseIndex = 0;
  late int enemyHp;
  late int enemyMaxHp;
  int _phaseTurn = 0;

  /// `null` khi trận chưa kết thúc.
  bool? won;
  final List<String> log = [];

  BattlePhase get phase => def.phases[phaseIndex];
  EnemyMove get nextMove => phase.pattern[_phaseTurn % phase.pattern.length];
  bool get finished => won != null;
  bool get canUseSkill => morale >= skillCost;

  BattleResult get result => BattleResult(
        won: won ?? false,
        damageTaken: damageTaken,
        moraleSpent: moraleSpent,
      );

  void _startPhase(int index) {
    phaseIndex = index;
    _phaseTurn = 0;
    enemyMaxHp = (phase.hp * (weakened ? 0.8 : 1.0)).round();
    enemyHp = enemyMaxHp;
    if (phase.intro.isNotEmpty) log.add(phase.intro);
  }

  void act(PlayerAction action) {
    if (finished) return;
    if (action == PlayerAction.skill && !canUseSkill) return;
    turn++;
    final move = nextMove;
    final enemyName = phase.name;

    // Người chơi ra đòn.
    var dealt = 0;
    switch (action) {
      case PlayerAction.attack:
        dealt = playerAtk;
        if (move == EnemyMove.defend) dealt = (dealt / 2).round();
      case PlayerAction.skill:
        morale -= skillCost;
        moraleSpent += skillCost;
        dealt = playerAtk * 2; // kỹ năng xuyên phòng thủ
      case PlayerAction.defend:
        break;
    }
    if (dealt > 0 && move == EnemyMove.rally) dealt = (dealt * 1.5).round();
    enemyHp = math.max(0, enemyHp - dealt);
    log.add(switch (action) {
      PlayerAction.attack => 'Lượt $turn: quân ta tấn công, gây $dealt sát thương.',
      PlayerAction.skill => 'Lượt $turn: quân ta dốc kế sách, gây $dealt sát thương.',
      PlayerAction.defend => 'Lượt $turn: quân ta dàn trận phòng thủ.',
    });

    if (enemyHp == 0) {
      log.add('$enemyName đã bị đánh bại.');
      if (phaseIndex + 1 >= def.phases.length) {
        won = true;
      } else {
        _startPhase(phaseIndex + 1); // địch mới vào trận, chưa kịp ra đòn
      }
      return;
    }

    // Địch phản đòn.
    var incoming = switch (move) {
      EnemyMove.attack => phase.atk,
      EnemyMove.heavy => phase.atk * 2,
      EnemyMove.defend || EnemyMove.rally => 0,
    };
    if (action == PlayerAction.defend && incoming > 0) {
      incoming = (incoming * defendReduction).round();
    }
    playerHp = math.max(0, playerHp - incoming);
    damageTaken += incoming;
    log.add(incoming > 0
        ? '$enemyName phản công, quân ta thiệt hại $incoming.'
        : '$enemyName không tấn công lượt này.');
    _phaseTurn++;

    if (playerHp == 0) {
      won = false;
      log.add('Quân ta không trụ nổi nữa.');
    } else if (def.scriptedDefeatTurn != null && turn >= def.scriptedDefeatTurn!) {
      won = false;
      log.add('Thế trận đã định — quân ta không thể xoay chuyển.');
    } else if (turn >= maxTurns) {
      won = false;
      log.add('Giằng co quá lâu, lương thảo cạn kiệt, buộc phải lui quân.');
    }
  }
}
