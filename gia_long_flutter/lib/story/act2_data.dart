import '../models/scene.dart';

/// HỒI 2: Những Năm Bôn Ba (1777–1787)
const act2Scenes = <Scene>[
  Scene(
    id: 'a2_start',
    act: 2,
    checkpoint: true,
    startQuests: ['Q2_VongLap'],
    title: 'Trở lại Gia Định',
    location: 'Gia Định — 1778–1780',
    text: 'Quân Đông Sơn của Đỗ Thanh Nhơn đánh bật quân Tây Sơn khỏi Gia Định. '
        'Nguyễn Ánh trở về giữa tiếng reo hò. Năm 1780, các tướng tôn ông lên ngôi vương.\n\n'
        'Nhưng ngai vàng còn lung lay. Đỗ Thanh Nhơn nắm trong tay đạo quân mạnh nhất, và triều đình '
        'mới chia làm hai phe: một phe tin ông ta, một phe thì thầm rằng Nhơn đã coi thường vương thượng.',
    choices: [
      Choice(
        text: 'Trọng dụng Đỗ Thanh Nhơn, giao thêm binh quyền',
        next: 'a2_court',
        effect: {'army': 12, 'morale': 5},
      ),
      Choice(
        text: 'Âm thầm phân tán bớt quyền của Nhơn',
        next: 'a2_court',
        effect: {'army': 5, 'diplomacy': 5},
      ),
    ],
  ),
  Scene(
    id: 'a2_court',
    act: 2,
    title: 'Quyền thần',
    location: 'Triều đình Gia Định — 1781',
    text: 'Trên triều, Đỗ Thanh Nhơn ngày càng lấn lướt: tự quyết việc quân, bớt xén cả chi tiêu '
        'trong cung. Các quan dâng sớ xin trừ khử kẻ "quyền thần".\n\n'
        'Một quyết định sẽ định hình lòng quân Đông Sơn — những người đã đổ máu đưa ngài về Gia Định.',
    historyNote: 'Trong lịch sử, năm 1781 Nguyễn Ánh cho giết Đỗ Thanh Nhơn. Quân Đông Sơn rã rời, '
        'nhiều người bỏ đi — một nguyên nhân khiến Gia Định thất thủ năm 1782. '
        'Lựa chọn hòa giải trong game là giả tưởng "nếu như".',
    choices: [
      Choice(
        text: 'Xử tử Đỗ Thanh Nhơn để giữ vương quyền',
        next: 'a2_fall',
        effect: {'army': -12, 'morale': -5},
        setFlags: ['giet_nhon'],
        logLabel: 'Xử tử Đỗ Thanh Nhơn',
      ),
      Choice(
        text: 'Triệu Nhơn vào, thẳng thắn phân định quyền hạn',
        next: 'a2_fall',
        requires: {'diplomacy': 15},
        effect: {'army': 5, 'morale': 5},
        setFlags: ['giu_nhon'],
        logLabel: 'Hòa giải với Đỗ Thanh Nhơn',
      ),
    ],
  ),
  Scene(
    id: 'a2_fall',
    act: 2,
    title: 'Mất Gia Định lần nữa',
    location: 'Sông Ngã Bảy — 1782',
    text: 'Mùa xuân năm 1782, Nguyễn Nhạc và Nguyễn Huệ đem hàng trăm chiến thuyền vào cửa Cần Giờ. '
        'Thủy quân Gia Định vỡ trận ở Ngã Bảy; viên chỉ huy người Bồ Đào Nha tên Manuel '
        'đốt tàu mình tự tận chứ không chịu hàng.\n\n'
        'Gia Định lại mất. Được — rồi lại mất.',
    choices: [
      Choice(
        text: 'Rút về Ba Giồng, gom góp tàn quân',
        next: 'a2_retake',
        effect: {'food': -5, 'army': -5},
      ),
    ],
  ),
  Scene(
    id: 'a2_retake',
    act: 2,
    title: 'Vòng lặp được — mất',
    location: 'Gia Định — 1782–1783',
    text: 'Khi đại quân Tây Sơn rút về Quy Nhơn, Châu Văn Tiếp cùng các tướng tái chiếm Gia Định. '
        'Niềm vui ngắn ngủi: năm 1783, Nguyễn Huệ trở lại, đánh tan quân Nguyễn. Nguyễn Ánh phải bỏ chạy '
        'ra Phú Quốc, rồi Côn Lôn, bị truy đuổi đến tận hải đảo.\n\n'
        'Lần thứ bao nhiêu rồi? Chẳng ai còn đếm nữa.',
    choices: [
      Choice(
        text: 'Cử người sang Xiêm La cầu viện',
        next: 'a2_siam',
        effect: {'diplomacy': 5},
        completeQuests: ['Q2_VongLap'],
        startQuests: ['Q2_XiemLa'],
      ),
      Choice(
        text: 'Bám trụ đánh du kích trong rừng U Minh',
        next: 'a2_guerrilla',
        effect: {'food': -10, 'morale': -5},
        completeQuests: ['Q2_VongLap'],
      ),
    ],
  ),
  Scene(
    id: 'a2_guerrilla',
    act: 2,
    title: 'Rừng tràm U Minh',
    location: 'U Minh — 1783',
    text: 'Mấy tháng đánh du kích trong rừng tràm chỉ đổi lấy thêm thương vong. Lương cạn, quân mỏi.\n\n'
        'Cuối cùng, Châu Văn Tiếp đích thân sang Xiêm xin viện binh, rồi quay về báo tin: '
        'vua Xiêm Rama I đồng ý tiếp đón.',
    choices: [
      Choice(text: 'Lên thuyền sang Xiêm', next: 'a2_siam', startQuests: ['Q2_XiemLa']),
    ],
  ),
  Scene(
    id: 'a2_siam',
    act: 2,
    title: 'Triều đình Xiêm La',
    location: 'Bangkok — 1784',
    text: 'Kinh thành Xiêm La rực rỡ mái chùa dát vàng. Vua Rama I tiếp Nguyễn Ánh như một vị khách quý — '
        'nhưng người Xiêm có tính toán của riêng họ: vùng đất Gia Định trù phú kia đâu phải không đáng để ý.\n\n'
        '"Trẫm có thể cho hai vạn quân thủy bộ và ba trăm chiến thuyền," nhà vua nói. '
        '"Hoặc nếu khanh muốn, chỉ lương thực và vũ khí."',
    historyNote: 'Năm 1784, vua Xiêm Rama I cử khoảng 2 vạn quân và 300 chiến thuyền theo Nguyễn Ánh '
        'về đánh Tây Sơn (sử sách ghi số lượng khác nhau). Quân Xiêm cướp phá dân chúng nặng nề, '
        'khiến lòng dân oán ghét.',
    choices: [
      Choice(
        text: 'Nhận hai vạn quân Xiêm',
        next: 'a2_siam_army',
        effect: {'army': 20, 'diplomacy': 5},
        setFlags: ['dung_quan_xiem'],
        logLabel: 'Dẫn hai vạn quân Xiêm về nước',
      ),
      Choice(
        text: 'Chỉ xin lương thực, vũ khí — không để quân ngoại bang vào đất mình',
        next: 'a2_siam_food',
        effect: {'food': 20, 'army': 5, 'morale': 5},
        logLabel: 'Chỉ xin lương thực, không nhận quân Xiêm',
      ),
    ],
  ),
  Scene(
    id: 'a2_siam_army',
    act: 2,
    title: 'Đồng minh cướp bóc',
    location: 'Miền Tây — cuối 1784',
    text: 'Quân Xiêm tiến vào Rạch Giá, Trà Ôn, Sa Đéc. Thắng được vài trận nhỏ, nhưng đi đến đâu '
        'họ cướp bóc đến đó. Dân làng quỳ trước ngựa Nguyễn Ánh khóc lóc kể tội.\n\n'
        'Viên tướng Xiêm cười nhạt: "Lính của ta cần được thưởng."',
    choices: [
      Choice(
        text: 'Nghiêm trị kẻ cướp bóc, dù mất lòng tướng Xiêm',
        next: 'a2_rachgam',
        effect: {'diplomacy': -10, 'morale': 10},
        setFlags: ['bao_ve_dan'],
        logLabel: 'Nghiêm trị quân Xiêm cướp bóc dân',
      ),
      Choice(
        text: 'Làm ngơ để giữ liên minh',
        next: 'a2_rachgam',
        effect: {'diplomacy': 5, 'morale': -12},
      ),
    ],
  ),
  Scene(
    id: 'a2_siam_food',
    act: 2,
    title: 'Viện binh không mời',
    location: 'Miền Tây — cuối 1784',
    text: 'Nguyễn Ánh trở về với thuyền đầy lương. Nhưng vua Xiêm vẫn quyết xuất quân — '
        'dưới danh nghĩa "giúp đỡ". Hai vạn lính Xiêm đổ bộ, và Nguyễn Ánh chỉ còn cách đi cùng họ, '
        'cố kiềm chế việc cướp bóc hết mức có thể.',
    choices: [
      Choice(text: 'Theo đoàn quân tiến về Mỹ Tho', next: 'a2_rachgam'),
    ],
  ),
  Scene(
    id: 'a2_rachgam',
    act: 2,
    type: SceneType.battle,
    battleId: 'b_rachgam',
    startQuests: ['Q2_RachGam'],
    title: 'Sông Tiền',
    location: 'Rạch Gầm – Xoài Mút — tháng Giêng 1785',
    text: 'Nguyễn Huệ từ Quy Nhơn vào Nam. Ông chọn khúc sông Tiền từ Rạch Gầm đến Xoài Mút — '
        'nơi hai bên bờ cây cối rậm rạp, cù lao Thới Sơn chắn giữa dòng — để giấu thủy binh và pháo.\n\n'
        'Sáng sớm, chiến thuyền Xiêm nối đuôi nhau xuôi dòng, không hay biết mình đang đi vào một cái bẫy.',
    historyNote: 'Trận Rạch Gầm – Xoài Mút (tháng 1/1785) là một trong những chiến thắng lừng lẫy nhất '
        'của Nguyễn Huệ; quân Xiêm gần như bị tiêu diệt. Trong game, đây là trận thua theo kịch bản: '
        'dù bạn làm gì, lịch sử vẫn đi theo hướng của nó.',
  ),
  Scene(
    id: 'a2_rachgam_after',
    act: 2,
    completeQuests: ['Q2_RachGam'],
    title: 'Mặt sông đỏ lửa',
    location: 'Sông Tiền — sau trận',
    text: 'Hai vạn quân Xiêm chỉ còn vài nghìn người chạy thoát theo đường bộ. Nguyễn Ánh cùng tàn quân '
        'lênh đênh, rồi một lần nữa trở lại Bangkok — lần này không phải khách quý, mà là kẻ lưu vong.\n\n'
        'Đó là thất bại cay đắng nhất đời ông. Và cũng là bài học: '
        'không thể dựa vào đội quân mà mình không kiểm soát được.',
    choices: [
      Choice(text: 'Sống lưu vong ở Xiêm', next: 'a2_exile', effect: {'morale': -5}),
    ],
  ),
  Scene(
    id: 'a2_exile',
    act: 2,
    title: 'Những năm lưu vong',
    location: 'Bangkok — 1785–1787',
    text: 'Tàn quân Nguyễn dựng trại ở ngoại ô Bangkok. Năm 1786, quân Miến Điện tràn sang đánh Xiêm, '
        'và vua Xiêm hỏi Nguyễn Ánh có muốn giúp một tay.\n\n'
        'Nợ ân tình phải trả, nhưng mỗi người lính đều quý như vàng.',
    historyNote: 'Sử nhà Nguyễn ghi quân của Nguyễn Ánh từng giúp Xiêm chống quân Miến Điện '
        'trong thời gian lưu vong (1785–1787).',
    choices: [
      Choice(
        text: 'Đem quân giúp Xiêm đánh Miến để trả ơn',
        next: 'a2_end',
        effect: {'army': -5, 'diplomacy': 12, 'morale': 5},
      ),
      Choice(
        text: 'Khéo léo từ chối, âm thầm tích trữ lực lượng',
        next: 'a2_end',
        effect: {'food': 10, 'army': 5, 'diplomacy': -5},
      ),
    ],
  ),
  Scene(
    id: 'a2_end',
    act: 2,
    completeQuests: ['Q2_XiemLa'],
    title: 'Tin từ phương Tây',
    location: 'Bangkok — mùa thu 1787',
    text: 'Tin tức vượt biển đến: Bá Đa Lộc — người đã mang theo Hoàng tử Cảnh mới lên năm làm tin — '
        'đã tới được triều đình Pháp ở Versailles.\n\n'
        'Cùng lúc đó, nội bộ Tây Sơn rạn nứt: Nguyễn Nhạc và Nguyễn Huệ đem quân đánh nhau. '
        'Cơ hội đã đến. Một đêm, Nguyễn Ánh để lại thư cảm tạ vua Xiêm rồi lặng lẽ xuống thuyền về nước.',
    choices: [
      Choice(text: 'Hồi 3 — Liên Minh Với Phương Tây', next: 'a3_start'),
    ],
  ),
];
