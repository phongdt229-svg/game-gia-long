import '../models/scene.dart';

/// HỒI 5: Cuộc Chiến Với Tây Sơn (1792–1801)
const act5Scenes = <Scene>[
  Scene(
    id: 'a5_start',
    act: 5,
    checkpoint: true,
    startQuests: ['Q5_QuyNhon'],
    title: 'Triều Tây Sơn mục ruỗng',
    location: 'Phú Xuân & Gia Định — 1792–1793',
    text: 'Quanh ngai vàng của vua trẻ Cảnh Thịnh, quyền thần Bùi Đắc Tuyên thao túng triều chính. '
        'Các danh tướng Trần Quang Diệu, Võ Văn Dũng bất mãn. Ở Quy Nhơn, Nguyễn Nhạc già yếu, '
        'nhìn cháu mình với ánh mắt nghi kỵ.\n\n'
        'Nhà Tây Sơn hùng mạnh đang mục ruỗng từ bên trong.',
    historyNote: 'Quang Trung mất ngày 16/9/1792. Con ông là Nguyễn Quang Toản (niên hiệu Cảnh Thịnh) '
        'lên ngôi khi mới 10 tuổi. Triều Tây Sơn nhanh chóng rơi vào tranh giành quyền lực: '
        'năm 1795, phe võ tướng giết Bùi Đắc Tuyên.',
    choices: [
      Choice(
        text: 'Cài mật thám, khai thác mâu thuẫn nội bộ Tây Sơn',
        next: 'a5_spies',
        effect: {'diplomacy': 5},
        startQuests: ['Q5_NoiLoan'],
      ),
      Choice(
        text: 'Dồn toàn lực Bắc tiến, không để địch kịp hồi sức',
        next: 'a5_campaign',
        effect: {'army': 5, 'food': -5},
      ),
    ],
  ),
  Scene(
    id: 'a5_spies',
    act: 5,
    title: 'Mật thư từ Phú Xuân',
    location: 'Gia Định — phòng mật thám',
    text: 'Mật thám báo về: phe Bùi Đắc Tuyên và phe các võ tướng đang như nước với lửa. '
        'Một vài tướng Tây Sơn cấp thấp đã ngầm gửi thư dò hỏi, xem Gia Định có dung nạp '
        'người quy thuận hay không.',
    choices: [
      Choice(
        text: 'Tung tin gây chia rẽ giữa các phe Tây Sơn',
        next: 'a5_campaign',
        effect: {'diplomacy': 5},
        setFlags: ['noi_loan'],
        completeQuests: ['Q5_NoiLoan'],
        logLabel: 'Tung tin ly gián triều Tây Sơn',
      ),
      Choice(
        text: 'Mở rộng cửa chiêu hàng, trọng đãi người quy thuận',
        next: 'a5_campaign',
        effect: {'army': 10, 'morale': 3},
        setFlags: ['chieu_hang'],
        completeQuests: ['Q5_NoiLoan'],
        logLabel: 'Chiêu hàng tướng sĩ Tây Sơn',
      ),
    ],
  ),
  Scene(
    id: 'a5_campaign',
    act: 5,
    title: 'Những mùa gió',
    location: 'Biển Đông — 1793–1799',
    text: 'Mỗi năm, khi gió mùa Tây Nam thổi, thủy quân Gia Định giương buồm ra Bắc đánh phá; '
        'khi gió đổi chiều, lại rút về. Năm này qua năm khác, vòng vây quanh Quy Nhơn — '
        'kinh đô cũ của Nguyễn Nhạc — mỗi lúc một siết chặt.\n\n'
        'Năm 1799, đại quân áp sát thành Quy Nhơn.',
    choices: [
      Choice(
        text: 'Dùng thủy quân phong tỏa cửa biển, cắt đường tiếp tế',
        next: 'a5_quynhon',
        effect: {'food': 5},
      ),
      Choice(
        text: 'Để bộ binh vây chặt các ngả đường núi',
        next: 'a5_quynhon',
        effect: {'army': 5, 'food': -5},
      ),
    ],
  ),
  Scene(
    id: 'a5_quynhon',
    act: 5,
    type: SceneType.battle,
    battleId: 'b_quynhon',
    title: 'Hạ thành Quy Nhơn',
    location: 'Thành Quy Nhơn — 1799',
    text: 'Tường thành Quy Nhơn sừng sững. Quân Tây Sơn trấn thủ đã nhiều tháng không được tiếp viện, '
        'nhưng vẫn quyết tử thủ. Võ Tánh, Nguyễn Văn Thành xin làm tiên phong.\n\n'
        'Nếu nội bộ địch đã bị lung lay, sức kháng cự của chúng sẽ yếu hơn.',
  ),
  Scene(
    id: 'a5_regroup_qn',
    act: 5,
    title: 'Lui quân',
    location: 'Doanh trại ngoài thành Quy Nhơn',
    text: 'Đợt công thành đầu tiên bị đẩy lùi. Xác lính hai bên nằm la liệt dưới chân tường. '
        'Nguyễn Ánh cho lui quân, chữa thương, gọi thêm viện binh từ Gia Định.',
    choices: [
      Choice(
        text: 'Chỉnh đốn và tấn công lần nữa',
        next: 'a5_quynhon',
        effect: {'army': 12, 'food': -5, 'morale': 5},
      ),
    ],
  ),
  Scene(
    id: 'a5_quynhon_won',
    act: 5,
    completeQuests: ['Q5_QuyNhon'],
    startQuests: ['Q5_PhuXuan'],
    title: 'Mật thư của Võ Tánh',
    location: 'Thành Bình Định — 1799–1801',
    text: 'Quy Nhơn thất thủ. Nguyễn Ánh đổi tên thành Bình Định, giao cho Võ Tánh và '
        'Lễ bộ Ngô Tùng Châu trấn giữ.\n\n'
        'Nhưng Tây Sơn phản công dữ dội: Trần Quang Diệu và Võ Văn Dũng đem đại quân vây kín thành. '
        'Một mật thư của Võ Tánh vượt vòng vây tới tay Nguyễn Ánh:\n\n'
        '"Quân chủ lực Tây Sơn đều dồn cả ở đây. Phú Xuân bỏ trống. Xin Chúa thượng đừng lo cứu thần, '
        'hãy đánh thẳng ra Phú Xuân."',
    historyNote: 'Năm 1799 Nguyễn Ánh chiếm Quy Nhơn, đổi tên là Bình Định. Năm 1800–1801, Võ Tánh và '
        'Ngô Tùng Châu bị Trần Quang Diệu vây hơn một năm, và đã gửi thư khuyên Nguyễn Ánh đánh thẳng Phú Xuân.',
    choices: [
      Choice(
        text: 'Nghe theo Võ Tánh — dồn lực đánh Phú Xuân',
        next: 'a5_thinai',
        setFlags: ['nghe_vo_tanh'],
        logLabel: 'Nghe lời Võ Tánh, dồn lực đánh Phú Xuân',
      ),
      Choice(
        text: 'Không bỏ người trung thần — đem quân giải vây trước',
        next: 'a5_rescue',
        effect: {'army': -10, 'morale': 5, 'food': -5},
        logLabel: 'Cố giải vây cho Võ Tánh',
      ),
    ],
  ),
  Scene(
    id: 'a5_rescue',
    act: 5,
    title: 'Vòng vây thép',
    location: 'Ngoài thành Bình Định',
    text: 'Ba lần đánh vào vòng vây, ba lần bị đẩy lùi. Trần Quang Diệu đắp lũy dài bao quanh thành, '
        'hàng hàng lớp lớp. Máu đổ vô ích.\n\n'
        'Cuối cùng Nguyễn Ánh hiểu: cách duy nhất cứu Võ Tánh là đánh vào nơi Tây Sơn không ngờ nhất.',
    choices: [
      Choice(text: 'Chuyển hướng: đánh thủy quân Tây Sơn ở Thị Nại', next: 'a5_thinai'),
    ],
  ),
  Scene(
    id: 'a5_thinai',
    act: 5,
    type: SceneType.battle,
    battleId: 'b_thinai',
    title: 'Thủy chiến Thị Nại',
    location: 'Cửa biển Thị Nại — tháng 2/1801',
    text: 'Để mở đường ra Bắc, phải phá hạm đội Tây Sơn đang án ngữ đầm Thị Nại — nơi có chiến thuyền lớn, '
        'pháo đài hai bên bờ. Đêm ấy, Nguyễn Ánh đích thân đốc chiến trên soái thuyền. '
        'Võ Di Nguy dẫn đầu mũi xung kích.',
    historyNote: 'Trận Thị Nại (1801) là một trong những trận thủy chiến lớn nhất lịch sử Việt Nam thời trung đại. '
        'Quân Nguyễn đốt cháy phần lớn hạm đội Tây Sơn; tướng Võ Di Nguy tử trận.',
  ),
  Scene(
    id: 'a5_regroup_tn',
    act: 5,
    title: 'Chờ con nước',
    location: 'Ngoài cửa Thị Nại',
    text: 'Hỏa pháo Tây Sơn quá dày, đội tiên phong phải rút ra ngoài cửa biển. '
        'Thủy thủ vá những chiếc thuyền hỏng, nạp thêm thuốc súng, chờ con nước kế tiếp.',
    choices: [
      Choice(
        text: 'Chờ thủy triều lên và tấn công lần nữa',
        next: 'a5_thinai',
        effect: {'army': 12, 'food': -5, 'morale': 5},
      ),
    ],
  ),
  Scene(
    id: 'a5_phuxuan',
    act: 5,
    completeQuests: ['Q5_PhuXuan'],
    title: 'Phú Xuân',
    location: 'Phú Xuân — tháng 6/1801',
    text: 'Thị Nại tan tành, đường biển rộng mở. Quân Nguyễn tiến vào Phú Xuân, vua Cảnh Thịnh bỏ chạy ra Bắc. '
        'Kinh thành cũ của chúa Nguyễn, sau hơn hai mươi năm, lại về tay dòng họ Nguyễn.\n\n'
        'Nhưng tin từ Bình Định đến cùng lúc: thành hết lương, Võ Tánh cho chất củi quanh lầu Bát Giác '
        'rồi tự thiêu, xin Trần Quang Diệu tha cho binh lính. Ngô Tùng Châu uống thuốc độc tự tận.',
    choices: [
      Choice(
        text: 'Lập đàn tế các trung thần đã khuất',
        next: 'a5_end',
        effect: {'morale': 10},
      ),
      Choice(
        text: 'Thề sẽ kết thúc chiến tranh thật nhanh để không ai phải hy sinh nữa',
        next: 'a5_end',
        effect: {'army': 5, 'morale': 5},
      ),
    ],
  ),
  Scene(
    id: 'a5_end',
    act: 5,
    title: 'Nhìn về phương Bắc',
    location: 'Phú Xuân — mùa xuân 1802',
    text: 'Tây Sơn chỉ còn giữ Bắc Hà. Nguyễn Ánh nhìn ra phía Bắc — nơi dòng sông Hồng chảy qua '
        'thành Thăng Long nghìn năm văn hiến.',
    choices: [
      Choice(text: 'Hồi 6 — Thống Nhất Đất Nước', next: 'a6_start'),
    ],
  ),
];
