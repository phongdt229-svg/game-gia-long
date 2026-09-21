import '../models/base_building.dart';

/// Màn xây dựng căn cứ (Hồi 4). `id` khớp với `Scene.baseId`.
const allBases = <BaseDef>[
  BaseDef(
    id: 'base_giadinh',
    title: 'Xây dựng Gia Định',
    turns: 6,
    next: 'a4_after_base',
    actions: [
      BaseAction(
        id: 'farm',
        name: 'Khai khẩn đồn điền',
        description: 'Chiêu mộ dân, khai hoang ruộng bỏ hoang.',
        effect: {'food': 12, 'morale': 2},
      ),
      BaseAction(
        id: 'train',
        name: 'Luyện binh',
        description: 'Tuyển và huấn luyện thêm binh sĩ.',
        effect: {'army': 10, 'food': -4},
      ),
      BaseAction(
        id: 'relief',
        name: 'Phát chẩn, an dân',
        description: 'Cấp lương cho dân nghèo, sửa nhà cửa sau chiến tranh.',
        effect: {'morale': 10, 'food': -3},
      ),
      BaseAction(
        id: 'shipyard',
        name: 'Đóng thuyền chiến',
        description: 'Mở xưởng đóng tàu ven sông Sài Gòn.',
        effect: {'army': 7, 'food': -3, 'diplomacy': 3},
      ),
      BaseAction(
        id: 'market',
        name: 'Mở chợ, thông thương',
        description: 'Khuyến khích buôn bán với thương nhân trong và ngoài nước.',
        effect: {'food': 5, 'diplomacy': 6},
      ),
      BaseAction(
        id: 'fort',
        name: 'Xây thành Bát Quái kiểu Vauban',
        description: 'Xây thành theo kiến trúc thành lũy phương Tây.',
        effect: {'army': 12, 'morale': 4, 'food': -4},
        requiresFlag: 'thanh_vauban',
        lockedHint: 'Cần có kỹ sư thành lũy Vauban (chọn ở Hồi 3)',
      ),
    ],
    goals: [
      BaseGoal(
        questId: 'Q4_CanCu',
        description: 'Quân lực từ 30 và lương thực từ 40',
        requires: {'army': 30, 'food': 40},
      ),
      BaseGoal(
        questId: 'Q4_LongDan',
        description: 'Tinh thần từ 60',
        requires: {'morale': 60},
      ),
    ],
  ),
];

final Map<String, BaseDef> basesById = {for (final b in allBases) b.id: b};
