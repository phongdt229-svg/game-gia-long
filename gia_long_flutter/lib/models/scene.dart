/// Mã đặc biệt dùng trong [Choice.next].
const String checkpointToken = '__checkpoint__'; // quay lại đầu Hồi
const String menuToken = '__menu__'; // về màn hình chính

bool isSpecialTarget(String next) => next == checkpointToken || next == menuToken;

enum SceneType {
  story, // cảnh truyện + lựa chọn
  battle, // mở màn hình chiến đấu theo lượt
  base, // mở màn hình xây dựng căn cứ
  ending, // cảnh kết, mở màn hình tổng kết
}

class Choice {
  const Choice({
    required this.text,
    required this.next,
    this.effect = const {},
    this.requires = const {},
    this.requiresFlag,
    this.excludeFlag,
    this.setFlags = const [],
    this.startQuests = const [],
    this.completeQuests = const [],
    this.logLabel,
  });

  final String text;
  final String next;

  /// Thay đổi chỉ số, ví dụ `{'food': -5, 'morale': 10}`.
  final Map<String, int> effect;

  /// Chỉ số tối thiểu để chọn được, ví dụ `{'diplomacy': 25}`.
  final Map<String, int> requires;
  final String? requiresFlag;

  /// Ẩn lựa chọn khi đã có flag này.
  final String? excludeFlag;
  final List<String> setFlags;
  final List<String> startQuests;
  final List<String> completeQuests;

  /// Lựa chọn quan trọng — được ghi vào màn hình tổng kết.
  final String? logLabel;
}

class Scene {
  const Scene({
    required this.id,
    required this.act,
    required this.title,
    required this.text,
    this.location,
    this.historyNote,
    this.type = SceneType.story,
    this.choices = const [],
    this.onEnterEffect = const {},
    this.setFlags = const [],
    this.startQuests = const [],
    this.completeQuests = const [],
    this.checkpoint = false,
    this.battleId,
    this.baseId,
  });

  final String id;
  final int act;
  final String title;
  final String text;
  final String? location;

  /// Thông tin lịch sử thật, tách riêng khỏi phần hư cấu của game.
  final String? historyNote;
  final SceneType type;
  final List<Choice> choices;
  final Map<String, int> onEnterEffect;
  final List<String> setFlags;
  final List<String> startQuests;
  final List<String> completeQuests;

  /// Cảnh đầu Hồi: lưu ảnh chụp trạng thái để chơi lại khi thua.
  final bool checkpoint;
  final String? battleId;
  final String? baseId;
}
