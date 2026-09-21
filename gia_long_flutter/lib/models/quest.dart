enum QuestType { main, side, hidden, event }

extension QuestTypeLabel on QuestType {
  String get label => switch (this) {
        QuestType.main => 'Chính',
        QuestType.side => 'Phụ',
        QuestType.hidden => 'Ẩn',
        QuestType.event => 'Sự kiện',
      };
}

class Quest {
  const Quest({
    required this.id,
    required this.act,
    required this.type,
    required this.title,
    required this.description,
    required this.unlockCondition,
    required this.reward,
    this.rewardEffect = const {},
  });

  final String id; // "Q3_CauVien"
  final int act; // 3
  final QuestType type;
  final String title;
  final String description;

  /// "start" | "complete:<questId>" | "secret"
  final String unlockCondition;

  /// Mô tả phần thưởng hiển thị cho người chơi.
  final String reward;

  /// Chỉ số được cộng khi hoàn thành.
  final Map<String, int> rewardEffect;
}
