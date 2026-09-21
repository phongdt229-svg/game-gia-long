enum EnemyMove { attack, heavy, defend, rally }

extension EnemyMoveLabel on EnemyMove {
  String get label => switch (this) {
        EnemyMove.attack => 'Tấn công',
        EnemyMove.heavy => 'Dốc toàn lực đánh mạnh — nên phòng thủ!',
        EnemyMove.defend => 'Co cụm phòng thủ — đòn thường sẽ yếu đi',
        EnemyMove.rally => 'Chấn chỉnh đội ngũ — cơ hội tấn công',
      };
}

class BattlePhase {
  const BattlePhase({
    required this.name,
    required this.hp,
    required this.atk,
    required this.pattern,
    this.intro = '',
  });

  final String name;
  final int hp;
  final int atk;

  /// Địch hành động lần lượt theo kịch bản này (lặp lại).
  final List<EnemyMove> pattern;
  final String intro;
}

class BattleDef {
  const BattleDef({
    required this.id,
    required this.title,
    required this.enemyName,
    required this.intro,
    required this.phases,
    required this.winNext,
    required this.loseNext,
    this.winText = 'Toàn thắng! Quân địch tan vỡ.',
    this.loseText = 'Quân ta tan vỡ, buộc phải rút lui!',
    this.scriptedDefeatTurn,
    this.weakenFlags = const [],
    this.winEffect = const {},
    this.winCompleteQuests = const [],
  });

  final String id;
  final String title;
  final String enemyName;
  final String intro;
  final List<BattlePhase> phases;
  final String winNext;
  final String loseNext;
  final String winText;
  final String loseText;

  /// Thất bại có kịch bản: trận tự kết thúc (thua) sau số lượt này.
  final int? scriptedDefeatTurn;

  /// Nếu người chơi có một trong các flag này, máu địch giảm 20%.
  final List<String> weakenFlags;
  final Map<String, int> winEffect;
  final List<String> winCompleteQuests;
}

class BattleResult {
  const BattleResult({
    required this.won,
    required this.damageTaken,
    required this.moraleSpent,
  });

  final bool won;
  final int damageTaken;
  final int moraleSpent;
}
