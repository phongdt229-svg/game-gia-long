import '../models/scene.dart';

/// HỒI 3: Liên Minh Với Phương Tây (1787)
const act3Scenes = <Scene>[
  Scene(
    id: 'a3_start',
    act: 3,
    checkpoint: true,
    startQuests: ['Q3_CauVien'],
    title: 'Phong thư xi đỏ',
    location: 'Long Xuyên — cuối 1787',
    text: 'Một con tàu buôn từ Pondicherry — thuộc địa của Pháp ở Ấn Độ — mang về một phong thư dày, '
        'đóng dấu xi đỏ. Nét chữ quen thuộc của Bá Đa Lộc:\n\n'
        '"Tâu Điện hạ, sau gần hai năm chờ đợi, triều đình Pháp đã chịu ký một hiệp ước với ta..."',
    choices: [
      Choice(text: 'Đọc tiếp bức thư', next: 'a3_letter'),
    ],
  ),
  Scene(
    id: 'a3_letter',
    act: 3,
    title: 'Hiệp ước Versailles',
    location: 'Thư từ Versailles — 28/11/1787',
    text: '"...Theo Hiệp ước, vua Louis XVI hứa gửi bốn tàu chiến, 1.650 binh sĩ cùng súng đạn. '
        'Đổi lại, Điện hạ sẽ nhượng cho Pháp đảo Côn Lôn và cửa biển Hội An (Tourane), cho thương nhân '
        'Pháp được buôn bán tự do, và khi Pháp có chiến tranh ở phương Đông, ta phải giúp quân lương."\n\n'
        'Bức thư run lên trong tay. Viện binh thì cần. Nhưng đất đai của tổ tiên...?',
    historyNote: 'Hiệp ước Versailles ký ngày 28/11/1787 giữa Bá Đa Lộc (thay mặt Nguyễn Ánh) và '
        'Bộ trưởng Ngoại giao Pháp Montmorin. Hiệp ước này chưa bao giờ được thực thi: nước Pháp đang '
        'khủng hoảng tài chính ngay trước Cách mạng 1789.',
    choices: [
      Choice(
        text: 'Nghe thêm các ý kiến khác trước khi quyết',
        next: 'a3_view_bishop',
        excludeFlag: 'da_chieu',
        startQuests: ['Q3_DaChieu'],
      ),
      Choice(
        text: 'Chấp thuận các điều khoản — viện binh là trên hết',
        next: 'a3_court',
        effect: {'diplomacy': 10, 'morale': -5},
        setFlags: ['chap_thuan'],
        logLabel: 'Chấp thuận toàn bộ Hiệp ước Versailles',
      ),
      Choice(
        text: 'Viết thư đề nghị bớt các điều khoản nhượng đất',
        next: 'a3_court',
        effect: {'diplomacy': 5, 'morale': 8},
        setFlags: ['mac_ca'],
        logLabel: 'Mặc cả, bớt các điều khoản nhượng đất',
      ),
    ],
  ),
  Scene(
    id: 'a3_view_bishop',
    act: 3,
    title: 'Góc nhìn thứ nhất',
    location: 'Lời Bá Đa Lộc (trong thư riêng)',
    text: '"Điện hạ đừng coi đây là bán nước. Người Pháp ở xa vạn dặm, còn Tây Sơn ở ngay trước cửa. '
        'Không có súng đạn, tàu chiến kiểu mới, Điện hạ sẽ mãi mãi chạy trốn. Còn ta — ta làm vậy vì tin '
        'Điện hạ sẽ là một minh quân, và cũng vì mong đạo của ta được tự do truyền giảng."\n\n'
        'Ông không giấu động cơ của mình. Điều đó, kỳ lạ thay, khiến lời ông đáng tin hơn.',
    choices: [
      Choice(text: 'Hỏi ý các nho thần trong triều', next: 'a3_view_scholar'),
    ],
  ),
  Scene(
    id: 'a3_view_scholar',
    act: 3,
    title: 'Góc nhìn thứ hai',
    location: 'Lời một lão nho trong triều',
    text: 'Một vị lão nho quỳ tâu: "Xưa nay, cầu quân ngoại bang chẳng khác nào rước voi về giày mả tổ. '
        'Cắt một hòn đảo hôm nay, ngày mai họ sẽ đòi cả giang sơn. Thắng Tây Sơn bằng sức mình thì chậm, '
        'nhưng giữ được thể diện và đất đai."\n\n'
        'Lời ông nặng như đá. Và, như lịch sử sẽ cho thấy gần một thế kỷ sau, không phải là không có lý.',
    choices: [
      Choice(text: 'Suy ngẫm', next: 'a3_view_history'),
    ],
  ),
  Scene(
    id: 'a3_view_history',
    act: 3,
    completeQuests: ['Q3_DaChieu'],
    setFlags: ['da_chieu'],
    title: 'Góc nhìn thứ ba',
    location: 'Người đời sau (ghi chú ngoài câu chuyện)',
    text: 'Các nhà sử học ngày nay vẫn tranh luận về việc Nguyễn Ánh cầu viện Pháp.\n\n'
        'Có ý kiến cho rằng đây là "cõng rắn cắn gà nhà", mở đường cho Pháp xâm lược năm 1858. '
        'Có ý kiến khác chỉ ra rằng Hiệp ước 1787 không được thực thi, số người Pháp sang giúp chỉ là '
        'vài chục đến vài trăm người tình nguyện (con số còn tranh cãi), và Nguyễn Ánh chưa từng '
        'nhượng đất cho Pháp.\n\n'
        'Lịch sử hiếm khi chỉ có một màu. Quyết định giờ nằm trong tay bạn.',
    choices: [
      Choice(text: 'Quay lại bức thư', next: 'a3_letter'),
    ],
  ),
  Scene(
    id: 'a3_court',
    act: 3,
    startQuests: ['Q3_SiQuan'],
    title: 'Hiệp ước trên giấy',
    location: 'Pondicherry — 1788–1789',
    text: 'Tin xấu nối tin xấu: Thống đốc Pondicherry là Conway từ chối thực hiện hiệp ước. '
        'Nước Pháp đang rối ren, sắp nổ ra cách mạng. Bốn tàu chiến, 1.650 binh sĩ — tất cả chỉ còn trên giấy.\n\n'
        'Nhưng Bá Đa Lộc không bỏ cuộc. Ông bỏ tiền riêng, vận động thương nhân quyên góp, mua tàu, '
        'súng đạn, và thuyết phục được một nhóm sĩ quan, thủy thủ tình nguyện theo mình về nước.',
    choices: [
      Choice(
        text: 'Đón tiếp các sĩ quan phương Tây, trọng dụng tài năng của họ',
        next: 'a3_officers',
        effect: {'diplomacy': 5},
      ),
      Choice(
        text: 'Chỉ nhận vũ khí, cảm ơn và gửi họ về',
        next: 'a3_prince',
        effect: {'morale': 5, 'army': 5},
        setFlags: ['tu_chu'],
        logLabel: 'Chỉ nhận vũ khí, không dùng sĩ quan phương Tây',
      ),
    ],
  ),
  Scene(
    id: 'a3_officers',
    act: 3,
    title: 'Những người tình nguyện',
    location: 'Cửa biển — đón đoàn tàu từ Pondicherry',
    text: 'Họ đến: Jean-Marie Dayot và Philippe Vannier — những thủy thủ lão luyện; Jean-Baptiste Chaigneau; '
        'kỹ sư Olivier de Puymanel, người am hiểu cách xây thành kiểu Vauban.\n\n'
        'Nguồn lực có hạn. Ngài muốn giao cho họ việc gì trước tiên?',
    historyNote: 'Những người Pháp đến giúp Nguyễn Ánh chủ yếu là người tình nguyện, được ông trả lương '
        'và phong chức. Olivier de Puymanel tham gia xây thành Gia Định (1790). '
        'Chaigneau và Vannier phục vụ triều Nguyễn đến năm 1824.',
    choices: [
      Choice(
        text: 'Giao Olivier thiết kế thành lũy kiên cố',
        next: 'a3_prince',
        effect: {'army': 6, 'morale': 4},
        setFlags: ['thanh_vauban', 'phao_binh_tay'],
        completeQuests: ['Q3_SiQuan'],
        logLabel: 'Giao Olivier de Puymanel thiết kế thành lũy',
      ),
      Choice(
        text: 'Giao Dayot, Vannier huấn luyện thủy quân và pháo binh',
        next: 'a3_prince',
        effect: {'army': 10},
        setFlags: ['thuy_quan_tay', 'phao_binh_tay'],
        completeQuests: ['Q3_SiQuan'],
        logLabel: 'Giao Dayot, Vannier huấn luyện thủy quân',
      ),
    ],
  ),
  Scene(
    id: 'a3_prince',
    act: 3,
    title: 'Hoàng tử trở về',
    location: 'Năm 1789',
    text: 'Hoàng tử Cảnh trở về sau mấy năm ở nước Pháp. Cậu bé chín tuổi nói tiếng Pháp trôi chảy, '
        'mặc áo Tây — và khi được đưa vào nhà thờ tổ, cậu nhất quyết không chịu lạy bài vị tổ tiên.\n\n'
        'Cả triều đình sững sờ nhìn Nguyễn Ánh.',
    historyNote: 'Hoàng tử Nguyễn Phúc Cảnh (1780–1801) từng từ chối lạy bàn thờ tổ tiên sau khi từ Pháp về, '
        'gây xôn xao triều đình. Ông mất vì bệnh đậu mùa năm 1801, khi mới 21 tuổi.',
    choices: [
      Choice(
        text: 'Ôn tồn giảng giải cho con về đạo hiếu, không trách phạt',
        next: 'a3_end',
        effect: {'morale': 5, 'diplomacy': 5},
      ),
      Choice(
        text: 'Nghiêm khắc buộc con làm tròn lễ nghĩa trước bá quan',
        next: 'a3_end',
        effect: {'morale': 8, 'diplomacy': -3},
      ),
    ],
  ),
  Scene(
    id: 'a3_end',
    act: 3,
    completeQuests: ['Q3_CauVien'],
    title: 'Sức mình là chính',
    location: 'Cuối Hồi 3',
    text: 'Viện binh chính thức của nước Pháp không bao giờ đến. Thứ thật sự đến là vài chiếc tàu, '
        'ít súng đạn, một nhóm người tình nguyện — và những kỹ thuật mới mà Nguyễn Ánh sẽ dùng để xây lại '
        'cơ nghiệp bằng chính sức người Việt.\n\n'
        'Gia Định vẫn trong tay Tây Sơn — nhưng không lâu nữa.',
    choices: [
      Choice(text: 'Hồi 4 — Tái Chiếm Gia Định', next: 'a4_start'),
    ],
  ),
];
