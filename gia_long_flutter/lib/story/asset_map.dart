import '../models/scene.dart';

/// Ánh xạ cảnh → hình nền / chân dung / nhạc. Đường dẫn trỏ tới file bạn thêm vào
/// thư mục `assets/` (xem `assets/README.md`); file chưa có thì bị bỏ qua.

/// Hình nền theo Hồi (dùng khi cảnh không có hình riêng).
const actBackgrounds = <int, String>{
  1: 'assets/images/backgrounds/act1_gia_dinh.jpg',
  2: 'assets/images/backgrounds/act2_xiem_la.jpg',
  3: 'assets/images/backgrounds/act3_phuong_tay.jpg',
  4: 'assets/images/backgrounds/act4_can_cu.jpg',
  5: 'assets/images/backgrounds/act5_bac_tien.jpg',
  6: 'assets/images/backgrounds/act6_thang_long.jpg',
};

/// Hình nền riêng cho một số cảnh (ưu tiên hơn hình theo Hồi).
const sceneBackgrounds = <String, String>{
  'a1_island': 'assets/images/backgrounds/dao_tho_chu.jpg',
  'a5_phuxuan': 'assets/images/backgrounds/phu_xuan.jpg',
  'a6_victory': 'assets/images/backgrounds/thang_long.jpg',
};

/// Chân dung nhân vật hiện trong cảnh (theo id cảnh).
const scenePortraits = <String, String>{
  'a1_start': 'assets/images/portraits/nguyen_anh.png',
  'a1_oath': 'assets/images/portraits/nguyen_anh.png',
  'a1_mangrove': 'assets/images/portraits/ba_da_loc.png',
  'a3_start': 'assets/images/portraits/ba_da_loc.png',
  'a3_prince': 'assets/images/portraits/hoang_tu_canh.png',
  'a5_quynhon_won': 'assets/images/portraits/vo_tanh.png',
  'a6_victory': 'assets/images/portraits/nguyen_anh.png',
  'a6_epilogue': 'assets/images/portraits/gia_long.png',
};

/// Nhạc nền theo Hồi (đường dẫn tính từ `assets/`, theo quy ước của `audioplayers`).
const actMusic = <int, String>{
  1: 'audio/act1_luu_vong.mp3',
  2: 'audio/act2_bon_ba.mp3',
  3: 'audio/act3_su_menh.mp3',
  4: 'audio/act4_can_cu.mp3',
  5: 'audio/act5_bac_tien.mp3',
  6: 'audio/act6_thong_nhat.mp3',
};

const battleMusic = 'audio/battle.mp3';

String? backgroundFor(Scene scene) => sceneBackgrounds[scene.id] ?? actBackgrounds[scene.act];

String? portraitFor(Scene scene) => scenePortraits[scene.id];

String? musicFor(Scene scene) => scene.type == SceneType.battle ? battleMusic : actMusic[scene.act];
