class BaseAction {
  const BaseAction({
    required this.id,
    required this.name,
    required this.description,
    required this.effect,
    this.requiresFlag,
    this.lockedHint,
  });

  final String id;
  final String name;
  final String description;
  final Map<String, int> effect;
  final String? requiresFlag;
  final String? lockedHint;
}

class BaseGoal {
  const BaseGoal({
    required this.questId,
    required this.description,
    this.requires = const {},
  });

  final String questId;
  final String description;
  final Map<String, int> requires;
}

class BaseDef {
  const BaseDef({
    required this.id,
    required this.title,
    required this.turns,
    required this.actions,
    required this.goals,
    required this.next,
  });

  final String id;
  final String title;

  /// Số mùa (lượt) được hành động.
  final int turns;
  final List<BaseAction> actions;
  final List<BaseGoal> goals;
  final String next;
}
