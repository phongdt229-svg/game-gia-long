import '../models/scene.dart';

/// HỒI 6: Thống Nhất Đất Nước (1802)
const act6Scenes = <Scene>[
  Scene(
    id: 'a6_start',
    act: 6,
    checkpoint: true,
    startQuests: ['Q6_ThangLong'],
    title: 'Niên hiệu Gia Long',
    location: 'Phú Xuân — tháng 6/1802',
    text: 'Trước khi ra Bắc, trăm quan dâng biểu xin Nguyễn Ánh lên ngôi hoàng đế. Ông chọn niên hiệu '
        'Gia Long — chữ "Gia" của Gia Định, nơi khởi nghiệp, và chữ "Long" của Thăng Long, '
        'nơi sẽ kết thúc hành trình.\n\n'
        'Hai mươi lăm năm, từ một thiếu niên trốn chạy trên chiếc xuồng nhỏ, đến ngày hôm nay.',
    historyNote: 'Ngày 1/6/1802, Nguyễn Ánh lên ngôi ở Phú Xuân, lấy niên hiệu Gia Long. Theo cách giải thích '
        'phổ biến, niên hiệu ghép từ Gia Định và Thăng Long, biểu thị sự thống nhất từ Nam chí Bắc.',
    choices: [
      Choice(text: 'Tiến quân ra Bắc Hà', next: 'a6_march'),
    ],
  ),
  Scene(
    id: 'a6_march',
    act: 6,
    title: 'Đường ra Bắc',
    location: 'Bắc Hà — tháng 7/1802',
    text: 'Đại quân tiến như nước vỡ bờ, thủy bộ song hành. Các trấn Bắc Hà lần lượt mở cửa. '
        'Người dân đứng hai bên đường, lo âu nhìn đoàn quân phương Nam — họ đã chịu quá nhiều binh đao.\n\n'
        'Người ta chờ xem vị vua mới sẽ đối đãi với đất Bắc ra sao.',
    choices: [
      Choice(
        text: 'Ban lệnh hiểu dụ: quan lại cũ quy thuận được giữ chức, cấm quân lính quấy nhiễu dân',
        next: 'a6_battle',
        effect: {'diplomacy': 10, 'morale': 5},
        setFlags: ['hieu_du'],
        logLabel: 'Ban lệnh hiểu dụ, vỗ yên dân Bắc Hà',
      ),
      Choice(
        text: 'Tiến quân thần tốc, không dừng lại đâu cả',
        next: 'a6_battle',
        effect: {'army': 8, 'food': -8},
      ),
    ],
  ),
  Scene(
    id: 'a6_battle',
    act: 6,
    type: SceneType.battle,
    battleId: 'b_thanglong',
    title: 'Trận Thăng Long',
    location: 'Thăng Long — tháng 7/1802',
    text: 'Vua Cảnh Thịnh dồn những lực lượng cuối cùng giữ Thăng Long: tượng binh, ngự lâm quân, '
        'những cựu binh từng theo Quang Trung đánh tan quân Thanh. Họ biết đây là trận cuối.\n\n'
        'Nguyễn Ánh cũng biết. Hai mươi lăm năm dồn lại trong một ngày.',
    historyNote: 'Trên thực tế, khi quân Nguyễn ra Bắc tháng 7/1802, quân Tây Sơn tan rã nhanh chóng và '
        'Thăng Long được chiếm mà không có đại chiến. Trận đánh nhiều giai đoạn ở đây là phần hư cấu '
        'để làm cao trào cho game.',
  ),
  Scene(
    id: 'a6_regroup',
    act: 6,
    title: 'Trước cửa thành',
    location: 'Ngoại thành Thăng Long',
    text: 'Đợt tấn công bị chặn lại trước cửa thành. Nhưng Tây Sơn đã kiệt quệ, '
        'còn quân Nguyễn được tiếp tế liên tục bằng đường biển.',
    choices: [
      Choice(
        text: 'Tập hợp lại và tổng công kích',
        next: 'a6_battle',
        effect: {'army': 15, 'food': -5, 'morale': 5},
      ),
    ],
  ),
  Scene(
    id: 'a6_victory',
    act: 6,
    title: 'Cờ trên thành Thăng Long',
    location: 'Thăng Long — tháng 7/1802',
    text: 'Cờ nhà Nguyễn tung bay trên thành Thăng Long. Vua Cảnh Thịnh bỏ chạy, rồi bị bắt. '
        'Nhà Tây Sơn — từng lừng lẫy đánh tan quân Xiêm, quân Thanh — chính thức sụp đổ.\n\n'
        'Giờ đây, trước mặt Gia Long là số phận của những người thuộc dòng họ Tây Sơn — '
        'kẻ thù đã giết gần hết gia tộc ông năm xưa.',
    historyNote: 'Trong lịch sử, Gia Long đã xử tử Cảnh Thịnh và nhiều người trong hoàng tộc Tây Sơn bằng những '
        'hình phạt rất tàn khốc, đồng thời cho khai quật mộ Nguyễn Nhạc, Nguyễn Huệ. Đây là điểm bị nhiều '
        'sử gia phê phán. Lựa chọn khoan dung trong game là giả tưởng "nếu như".',
    choices: [
      Choice(
        text: 'Khoan dung — kết thúc hận thù, tha cho thân tộc Tây Sơn',
        next: 'a6_epilogue',
        effect: {'morale': 8, 'diplomacy': 5},
        setFlags: ['khoan_dung'],
        logLabel: 'Khoan dung với thân tộc Tây Sơn',
      ),
      Choice(
        text: 'Trừng trị theo luật đương thời — báo thù cho gia tộc',
        next: 'a6_epilogue',
        effect: {'morale': -5, 'army': 5},
        setFlags: ['bao_thu'],
        logLabel: 'Trừng trị nghiêm khắc thân tộc Tây Sơn',
      ),
    ],
  ),
  Scene(
    id: 'a6_epilogue',
    act: 6,
    type: SceneType.ending,
    completeQuests: ['Q6_ThangLong'],
    title: 'Non sông thu về một mối',
    location: 'Việt Nam — 1802 trở đi',
    text: 'Lần đầu tiên sau hơn hai trăm năm chia cắt — Đàng Trong, Đàng Ngoài, rồi nội chiến — '
        'một dải đất từ ải Nam Quan đến mũi Cà Mau thu về một mối.\n\n'
        'Năm 1804, quốc hiệu Việt Nam chính thức được sử dụng. Kinh đô đặt ở Phú Xuân – Huế.\n\n'
        'Hành trình 25 năm đã đến hồi kết...',
  ),
];
