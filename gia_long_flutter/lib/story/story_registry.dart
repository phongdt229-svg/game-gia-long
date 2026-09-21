import '../models/scene.dart';
import 'act1_data.dart';
import 'act2_data.dart';
import 'act3_data.dart';
import 'act4_data.dart';
import 'act5_data.dart';
import 'act6_data.dart';

export 'bases_data.dart';
export 'battles_data.dart';
export 'quests_data.dart';

const allScenes = <Scene>[
  ...act1Scenes,
  ...act2Scenes,
  ...act3Scenes,
  ...act4Scenes,
  ...act5Scenes,
  ...act6Scenes,
];

final Map<String, Scene> sceneById = {for (final s in allScenes) s.id: s};

const actTitles = {
  1: 'Hồi 1 — Sụp Đổ Và Chạy Trốn',
  2: 'Hồi 2 — Những Năm Bôn Ba',
  3: 'Hồi 3 — Liên Minh Với Phương Tây',
  4: 'Hồi 4 — Tái Chiếm Gia Định',
  5: 'Hồi 5 — Cuộc Chiến Với Tây Sơn',
  6: 'Hồi 6 — Thống Nhất Đất Nước',
};
