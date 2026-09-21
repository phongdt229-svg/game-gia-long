import '../models/battle.dart';

/// Các trận đánh theo lượt (Hồi 2, 5, 6). `id` khớp với `Scene.battleId`.
const allBattles = <BattleDef>[
  // Hồi 2 — thất bại có kịch bản: dù làm gì trận vẫn kết thúc bằng thất bại.
  BattleDef(
    id: 'b_rachgam',
    title: 'Trận Rạch Gầm – Xoài Mút',
    enemyName: 'Thủy quân Nguyễn Huệ',
    intro: 'Pháo từ hai bờ sông đồng loạt nổ vang. Chiến thuyền Xiêm bị chặn cả đầu lẫn đuôi.',
    phases: [
      BattlePhase(
        name: 'Thủy quân Tây Sơn phục kích',
        hp: 400,
        atk: 10,
        pattern: [EnemyMove.attack, EnemyMove.heavy, EnemyMove.attack, EnemyMove.heavy],
        intro: 'Thuyền của Nguyễn Huệ ập ra từ các cù lao, lửa cháy rực mặt sông.',
      ),
    ],
    scriptedDefeatTurn: 4,
    winNext: 'a2_rachgam_after',
    loseNext: 'a2_rachgam_after',
    loseText: 'Hai vạn quân Xiêm tan tác. Nguyễn Ánh cùng tàn quân phải bỏ thuyền chạy thoát theo đường bộ.',
  ),
  // Hồi 5
  BattleDef(
    id: 'b_quynhon',
    title: 'Hạ thành Quy Nhơn',
    enemyName: 'Quân Tây Sơn trấn thủ Quy Nhơn',
    intro: 'Thang công thành dựng sát chân tường, tiếng trống trận vang dội.',
    phases: [
      BattlePhase(
        name: 'Tiền đồn Tây Sơn',
        hp: 50,
        atk: 7,
        pattern: [EnemyMove.attack, EnemyMove.attack, EnemyMove.rally],
        intro: 'Quân Tây Sơn tử thủ ở các đồn ngoài thành.',
      ),
      BattlePhase(
        name: 'Thủ thành Quy Nhơn',
        hp: 60,
        atk: 8,
        pattern: [EnemyMove.defend, EnemyMove.attack, EnemyMove.heavy, EnemyMove.rally],
        intro: 'Cổng thành đóng chặt, quân thủ thành co cụm sau tường cao.',
      ),
    ],
    weakenFlags: ['noi_loan', 'chieu_hang'],
    winNext: 'a5_quynhon_won',
    loseNext: 'a5_regroup_qn',
    winText: 'Cờ Tây Sơn trên thành Quy Nhơn bị hạ xuống!',
    loseText: 'Đợt công thành bị đẩy lùi. Quân ta phải lui về doanh trại.',
    winEffect: {'morale': 5},
  ),
  BattleDef(
    id: 'b_thinai',
    title: 'Thủy chiến Thị Nại',
    enemyName: 'Thủy quân Tây Sơn',
    intro: 'Hàng trăm chiến thuyền dàn trận trong đầm Thị Nại, pháo hai bên bờ chĩa ra cửa biển.',
    phases: [
      BattlePhase(
        name: 'Chiến thuyền tiên phong',
        hp: 55,
        atk: 8,
        pattern: [EnemyMove.attack, EnemyMove.heavy, EnemyMove.rally],
        intro: 'Thuyền tiên phong Tây Sơn lao ra chặn đầu.',
      ),
      BattlePhase(
        name: 'Soái thuyền Tây Sơn',
        hp: 70,
        atk: 9,
        pattern: [EnemyMove.defend, EnemyMove.attack, EnemyMove.heavy, EnemyMove.rally],
        intro: 'Soái thuyền dày đặc hỏa pháo, quyết chiến đến cùng.',
      ),
    ],
    weakenFlags: ['phao_binh_tay', 'thuy_quan_tay'],
    winNext: 'a5_phuxuan',
    loseNext: 'a5_regroup_tn',
    winText: 'Hạm đội Tây Sơn bốc cháy! Đường ra Phú Xuân đã mở.',
    loseText: 'Hỏa pháo quá dày. Đội tiên phong phải rút ra ngoài cửa biển.',
    winEffect: {'morale': 8},
  ),
  // Hồi 6 — trận cuối, nhiều giai đoạn.
  BattleDef(
    id: 'b_thanglong',
    title: 'Trận Thăng Long',
    enemyName: 'Quân Tây Sơn cuối cùng',
    intro: 'Hai mươi lăm năm dồn lại trong một ngày. Trống trận vang khắp thành Thăng Long.',
    phases: [
      BattlePhase(
        name: 'Tượng binh',
        hp: 60,
        atk: 9,
        pattern: [EnemyMove.attack, EnemyMove.heavy, EnemyMove.rally],
        intro: 'Đàn voi chiến lao thẳng vào hàng quân.',
      ),
      BattlePhase(
        name: 'Ngự lâm quân',
        hp: 70,
        atk: 10,
        pattern: [EnemyMove.attack, EnemyMove.defend, EnemyMove.heavy, EnemyMove.rally],
        intro: 'Cấm binh giữ chặt cổng thành, tường khiên dày đặc.',
      ),
      BattlePhase(
        name: 'Cựu binh Quang Trung',
        hp: 80,
        atk: 11,
        pattern: [
          EnemyMove.heavy,
          EnemyMove.attack,
          EnemyMove.defend,
          EnemyMove.attack,
          EnemyMove.rally,
        ],
        intro: 'Những cựu binh từng đánh tan quân Thanh tử chiến nơi cửa cung.',
      ),
    ],
    weakenFlags: ['hieu_du', 'thanh_vauban'],
    winNext: 'a6_victory',
    loseNext: 'a6_regroup',
    winText: 'Cờ nhà Nguyễn tung bay trên thành Thăng Long!',
    loseText: 'Đợt tấn công bị chặn lại trước cửa thành.',
  ),
];

final Map<String, BattleDef> battlesById = {for (final b in allBattles) b.id: b};
