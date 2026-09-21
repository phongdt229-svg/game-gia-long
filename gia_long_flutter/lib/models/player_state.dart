import 'dart:convert';

const String startSceneId = 'a1_start';

class PlayerState {
  PlayerState({
    required this.sceneId,
    required this.stats,
    Set<String>? flags,
    Set<String>? activeQuests,
    Set<String>? completedQuests,
    List<String>? choiceLog,
    this.checkpoint,
  })  : flags = flags ?? <String>{},
        activeQuests = activeQuests ?? <String>{},
        completedQuests = completedQuests ?? <String>{},
        choiceLog = choiceLog ?? <String>[];

  factory PlayerState.newGame() => PlayerState(
        sceneId: startSceneId,
        stats: Map.of(initialStats),
      );

  static const statKeys = ['food', 'morale', 'army', 'diplomacy'];
  static const statLabels = {
    'food': 'Lương thực',
    'morale': 'Tinh thần',
    'army': 'Quân lực',
    'diplomacy': 'Ngoại giao',
  };
  static const initialStats = {
    'food': 50,
    'morale': 50,
    'army': 10,
    'diplomacy': 10,
  };
  static const maxStat = 100;

  String sceneId;
  final Map<String, int> stats;
  final Set<String> flags;
  final Set<String> activeQuests;
  final Set<String> completedQuests;

  /// Nhật ký các lựa chọn quan trọng (hiện ở màn tổng kết).
  final List<String> choiceLog;

  /// Ảnh chụp trạng thái (JSON) ở đầu Hồi hiện tại.
  String? checkpoint;

  int stat(String key) => stats[key] ?? 0;

  void applyEffect(Map<String, int> effect) {
    effect.forEach((key, delta) {
      stats[key] = (stat(key) + delta).clamp(0, maxStat).toInt();
    });
  }

  bool meets(Map<String, int> requires) =>
      requires.entries.every((e) => stat(e.key) >= e.value);

  /// "+5 Lương thực, -10 Tinh thần"
  static String describeEffect(Map<String, int> effect) => effect.entries
      .map((e) => '${e.value >= 0 ? '+' : ''}${e.value} ${statLabels[e.key] ?? e.key}')
      .join(', ');

  Map<String, dynamic> toJson() => {
        'sceneId': sceneId,
        'stats': stats,
        'flags': flags.toList(),
        'activeQuests': activeQuests.toList(),
        'completedQuests': completedQuests.toList(),
        'choiceLog': choiceLog,
        'checkpoint': checkpoint,
      };

  factory PlayerState.fromJson(Map<String, dynamic> json) {
    final rawStats = json['stats'];
    return PlayerState(
      sceneId: json['sceneId'] as String? ?? startSceneId,
      stats: {
        for (final k in statKeys)
          k: (rawStats is Map ? rawStats[k] as num? : null)?.toInt() ?? initialStats[k]!,
      },
      flags: _stringSet(json['flags']),
      activeQuests: _stringSet(json['activeQuests']),
      completedQuests: _stringSet(json['completedQuests']),
      choiceLog: json['choiceLog'] is List
          ? (json['choiceLog'] as List).map((e) => e.toString()).toList()
          : <String>[],
      checkpoint: json['checkpoint'] as String?,
    );
  }

  /// Chụp trạng thái hiện tại (không kèm checkpoint cũ).
  String snapshot() => jsonEncode(toJson()..remove('checkpoint'));

  static PlayerState fromSnapshot(String snapshot) =>
      PlayerState.fromJson(jsonDecode(snapshot) as Map<String, dynamic>);

  static Set<String> _stringSet(dynamic value) =>
      value is List ? value.map((e) => e.toString()).toSet() : <String>{};
}
