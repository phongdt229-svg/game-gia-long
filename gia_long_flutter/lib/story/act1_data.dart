import '../models/scene.dart';

/// HỒI 1: Sụp Đổ Và Chạy Trốn (1777)
const act1Scenes = <Scene>[
  Scene(
    id: 'a1_start',
    act: 1,
    checkpoint: true,
    startQuests: ['Q1_GiaDinh'],
    title: 'Đêm Gia Định thất thủ',
    location: 'Thành Gia Định — năm 1777',
    text: 'Lửa đỏ rực trời Gia Định. Tiếng trống trận của quân Tây Sơn dội qua '
        'từng lớp tường thành. Trong phủ chúa, người ta hớt hải thu dọn ấn tín, sổ sách.\n\n'
        'Nguyễn Ánh — mười lăm tuổi, cháu của Định vương Nguyễn Phúc Thuần — đứng giữa sân, '
        'tay nắm chặt thanh gươm quá nặng so với tuổi mình. Một lão tướng quỳ xuống:\n\n'
        '"Hoàng tôn, thành không giữ được nữa. Xin người định liệu!"',
    historyNote: 'Năm 1777, quân Tây Sơn do Nguyễn Lữ và Nguyễn Huệ chỉ huy chiếm Gia Định. '
        'Định vương Nguyễn Phúc Thuần và Tân Chính vương Nguyễn Phúc Dương bị bắt và bị giết. '
        'Nguyễn Ánh (sinh năm 1762) là một trong số rất ít người thuộc dòng chúa Nguyễn thoát nạn.',
    choices: [
      Choice(
        text: 'Theo đường sông trốn đi ngay trong đêm',
        next: 'a1_river',
        effect: {'food': -5},
      ),
      Choice(
        text: 'Ở lại chờ tin Định vương và viện binh',
        next: 'a1_wait',
        effect: {'morale': 5},
      ),
      Choice(
        text: 'Mở kho lương phát cho dân rồi mới đi',
        next: 'a1_granary',
        effect: {'food': -10, 'morale': 15},
        setFlags: ['nhan_tu'],
        logLabel: 'Mở kho lương cứu dân trong đêm Gia Định thất thủ',
      ),
    ],
  ),
  Scene(
    id: 'a1_granary',
    act: 1,
    title: 'Kho lương mở cửa',
    location: 'Kho lương thành Gia Định',
    text: 'Cửa kho bật mở. Dân nghèo quanh thành ùa tới, người vác bao gạo, người quỳ lạy tạ ơn.\n\n'
        'Một cậu bé chài lưới tên Út nắm vạt áo Nguyễn Ánh: "Con biết một con rạch nhỏ, '
        'lính Tây Sơn không canh. Con dẫn đường cho ngài!"\n\n'
        'Lương thực vơi đi, nhưng lòng người ở lại.',
    choices: [
      Choice(text: 'Theo cậu bé ra bến rạch', next: 'a1_river', effect: {'morale': 5}),
    ],
  ),
  Scene(
    id: 'a1_wait',
    act: 1,
    title: 'Tin dữ từ Long Xuyên',
    location: 'Phủ chúa — ba ngày sau',
    text: 'Ba ngày chờ đợi dài như ba năm. Rồi tin dữ đến: Định vương cùng Tân Chính vương '
        'đã bị quân Tây Sơn bắt và xử tử. Dòng họ Nguyễn ở Đàng Trong gần như bị tận diệt.\n\n'
        'Những người còn theo phò đều nhìn về phía chàng thiếu niên. '
        'Giờ đây, Nguyễn Ánh là ngọn cờ cuối cùng.',
    choices: [
      Choice(
        text: 'Nuốt nước mắt, lập tức rời thành',
        next: 'a1_river',
        effect: {'morale': -5},
      ),
      Choice(
        text: 'Dẫn vài trăm quân liều chết phá vây',
        next: 'a1_breakout',
        effect: {'army': -5, 'morale': 5},
      ),
    ],
  ),
  Scene(
    id: 'a1_breakout',
    act: 1,
    title: 'Phá vây',
    location: 'Cửa thành phía Tây',
    text: 'Mũi giáo Tây Sơn dày như rừng. Đội cảm tử mở được một lối thoát, nhưng phần lớn '
        'không trở về. Nguyễn Ánh thoát ra với áo giáp đẫm máu và một bài học đắt giá: '
        'dũng cảm thôi chưa đủ, phải biết chờ thời.\n\n'
        'Con đường duy nhất còn lại là sông nước miền Tây.',
    choices: [
      Choice(text: 'Xuống xuồng, xuôi theo kênh rạch', next: 'a1_river'),
    ],
  ),
  Scene(
    id: 'a1_river',
    act: 1,
    startQuests: ['Q1_RaBien'],
    title: 'Trạm gác trên sông',
    location: 'Kênh rạch miền Tây',
    text: 'Chiếc xuồng nhỏ lướt giữa rừng bần, rừng đước. Mỗi khúc quanh là một lần tim thắt lại. '
        'Phía trước, ánh đuốc của một trạm tuần Tây Sơn chắn ngang lối ra sông lớn.\n\n'
        'Người chèo xuồng thì thầm: "Chờ trời tối hẳn thì an toàn hơn, '
        'nhưng lương khô chỉ còn đủ vài bữa..."',
    choices: [
      Choice(
        text: 'Nấp trong rừng đước chờ trời tối',
        next: 'a1_mangrove',
        effect: {'food': -5},
      ),
      Choice(
        text: 'Lao xuồng vượt trạm gác đúng lúc địch đổi canh',
        next: 'a1_dash',
        requires: {'morale': 55},
        effect: {'morale': 5, 'army': -2},
      ),
    ],
  ),
  Scene(
    id: 'a1_mangrove',
    act: 1,
    title: 'Túp lều giữa rừng đước',
    location: 'Rừng đước — gần sáng',
    text: 'Muỗi rừng, nước lợ, và đêm đen đặc. Gần sáng, một ngọn đèn leo lét hiện ra: '
        'túp lều của một nhà truyền giáo. Người đàn ông ngoại quốc tóc đã điểm bạc mở cửa, '
        'nói tiếng Việt lơ lớ:\n\n'
        '"Ta là Pigneau, người ở đây gọi ta là Bá Đa Lộc. Vào đi, lính Tây Sơn sắp lục soát tới đây."',
    historyNote: 'Giám mục Pierre Pigneau de Behaine (tên Việt: Bá Đa Lộc) từng che giấu '
        'Nguyễn Ánh năm 1777 khi ông lẩn trốn quân Tây Sơn ở vùng Hà Tiên – Long Xuyên. '
        'Đây là khởi đầu cho mối quan hệ kéo dài hơn 20 năm giữa hai người.',
    choices: [
      Choice(
        text: 'Nhận sự che chở của Bá Đa Lộc',
        next: 'a1_island',
        effect: {'diplomacy': 10},
        setFlags: ['gap_ba_da_loc'],
        logLabel: 'Nhận sự che chở của Bá Đa Lộc',
      ),
      Choice(
        text: 'Cảm ơn nhưng từ chối — tự tìm đường ra biển',
        next: 'a1_island',
        effect: {'morale': 5, 'food': -5},
      ),
    ],
  ),
  Scene(
    id: 'a1_dash',
    act: 1,
    title: 'Vượt trạm gác',
    location: 'Cửa sông lớn',
    text: 'Đúng lúc trống đổi canh vang lên, xuồng lao vút qua mũi trạm gác. Tên bắn xé nước '
        'ngay sát mạn. Hai người chèo trúng tên, nhưng xuồng đã ra được sông lớn rồi trôi dần ra cửa biển.\n\n'
        'Phía xa, những hòn đảo xanh thẫm hiện lên trong sương sớm.',
    choices: [
      Choice(text: 'Hướng mũi xuồng ra đảo', next: 'a1_island'),
    ],
  ),
  Scene(
    id: 'a1_island',
    act: 1,
    completeQuests: ['Q1_RaBien'],
    title: 'Đảo hoang',
    location: 'Đảo Thổ Chu',
    text: 'Đảo Thổ Chu hoang vắng, chỉ có gió và sóng. Gạo cạn, người theo phò phải đào củ, '
        'hái rau dại, bắt ốc ven ghềnh mà sống. Có đêm, Nguyễn Ánh nghe binh sĩ thì thầm chuyện '
        'bỏ trốn về đất liền.\n\n'
        'Chỉ còn vài bao gạo cuối cùng trong khoang thuyền.',
    historyNote: 'Nguyễn Ánh thực sự nhiều lần phải lánh ra các đảo Phú Quốc, Côn Lôn, Thổ Chu, '
        'nhất là giai đoạn 1782–1783, có lúc phải ăn rau cỏ cầm hơi. Game gộp những lần lưu vong '
        'này vào Hồi 1 để giữ nhịp truyện.',
    choices: [
      Choice(
        text: 'Chia đều từng bát gạo cho mọi người, kể cả mình',
        next: 'a1_oath',
        effect: {'food': -5, 'morale': 12},
        setFlags: ['dong_cam'],
        logLabel: 'Chia đều lương thực với binh sĩ trên đảo hoang',
      ),
      Choice(
        text: 'Giữ phần gạo cho các tướng để còn sức chỉ huy',
        next: 'a1_oath',
        effect: {'food': 5, 'morale': -12},
      ),
    ],
  ),
  Scene(
    id: 'a1_oath',
    act: 1,
    completeQuests: ['Q1_GiaDinh'],
    title: 'Lời thề trên cát',
    location: 'Bờ biển Thổ Chu — đêm cuối',
    text: 'Đêm cuối trên đảo, Nguyễn Ánh đứng trước biển. Trong tay chỉ còn vài chục người, '
        'vài chiếc thuyền mục. Nhưng tin từ đất liền vọng ra: Đỗ Thanh Nhơn đang tập hợp '
        'quân Đông Sơn ở Ba Giồng, chờ ngọn cờ của dòng họ Nguyễn.\n\n'
        'Chàng thiếu niên rút gươm, vạch lên cát:\n\n'
        '"Ngày nào còn sống, ngày đó còn khôi phục cơ nghiệp."',
    choices: [
      Choice(text: 'Hồi 2 — Những Năm Bôn Ba', next: 'a2_start'),
    ],
  ),
];
