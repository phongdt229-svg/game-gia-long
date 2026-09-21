import '../models/scene.dart';

/// HỒI 4: Tái Chiếm Gia Định (1788)
const act4Scenes = <Scene>[
  Scene(
    id: 'a4_start',
    act: 4,
    checkpoint: true,
    startQuests: ['Q4_TroVe'],
    title: 'Thời cơ',
    location: 'Long Xuyên — mùa hè 1788',
    text: 'Nguyễn Huệ đang dồn toàn lực ra Bắc Hà — quân Thanh lăm le tràn qua biên giới. '
        'Gia Định chỉ còn tướng Phạm Văn Tham cầm quân trấn giữ.\n\n'
        'Các tướng trẻ Võ Tánh, Nguyễn Văn Thành đồng thanh: "Đây là thời cơ ngàn năm có một!"',
    historyNote: 'Tháng 9/1788, Nguyễn Ánh tái chiếm Gia Định. Tướng Tây Sơn Phạm Văn Tham rút về Ba Thắc, '
        'đến năm 1789 thì ra hàng. Game sắp xếp các Hồi theo chủ đề: thực tế các sĩ quan Pháp (Hồi 3) '
        'đến năm 1789, sau khi Gia Định đã được tái chiếm.',
    choices: [
      Choice(
        text: 'Đánh thẳng vào thành Gia Định khi địch còn lơ là',
        next: 'a4_assault',
        effect: {'army': -6, 'morale': 10},
      ),
      Choice(
        text: 'Cắt đường tiếp tế, gửi thư chiêu dụ, ép Phạm Văn Tham rút lui',
        next: 'a4_negotiate',
        requires: {'diplomacy': 25},
        effect: {'food': -5, 'diplomacy': 5},
      ),
    ],
  ),
  Scene(
    id: 'a4_assault',
    act: 4,
    title: 'Đêm công thành',
    location: 'Thành Gia Định',
    text: 'Đêm không trăng, quân Nguyễn vượt sông, bắc thang trèo thành. Võ Tánh dẫn đầu đội quân Kiến Hòa, '
        'hò reo xông lên. Trận đánh ác liệt đến sáng, cờ Tây Sơn trên vọng lâu bị chặt xuống.',
    choices: [
      Choice(text: 'Tiến vào thành', next: 'a4_retaken'),
    ],
  ),
  Scene(
    id: 'a4_negotiate',
    act: 4,
    title: 'Vòng vây im lặng',
    location: 'Các ngả sông quanh Gia Định',
    text: 'Thuyền chiến Nguyễn chặn các ngả sông, lương thảo từ Quy Nhơn không vào được. '
        'Thư chiêu dụ được bắn vào thành mỗi ngày.\n\n'
        'Một tháng sau, Phạm Văn Tham lặng lẽ bỏ thành, rút về Ba Thắc. '
        'Gia Định về tay mà gần như không đổ máu.',
    choices: [
      Choice(text: 'Tiến vào thành', next: 'a4_retaken', effect: {'morale': 5}),
    ],
  ),
  Scene(
    id: 'a4_retaken',
    act: 4,
    completeQuests: ['Q4_TroVe'],
    startQuests: ['Q4_CanCu', 'Q4_LongDan'],
    title: 'Mười một năm',
    location: 'Gia Định — 1788',
    text: 'Mười một năm sau đêm chạy trốn, Nguyễn Ánh bước vào thành Gia Định. '
        'Lần này, ông thề sẽ không để mất nó thêm lần nào nữa.\n\n'
        'Nhưng đất Gia Định sau chiến tranh xác xơ: ruộng bỏ hoang, dân tản mát, quân lính thiếu áo giáp. '
        'Cần xây dựng lại tất cả — từ hạt lúa đến tường thành.',
    choices: [
      Choice(text: 'Bắt tay xây dựng căn cứ', next: 'a4_base'),
    ],
  ),
  Scene(
    id: 'a4_base',
    act: 4,
    type: SceneType.base,
    baseId: 'base_giadinh',
    title: 'Xây dựng Gia Định',
    location: 'Gia Định — 1788–1790',
    text: 'Sáu mùa vụ. Mỗi mùa, ngài chỉ đủ nhân lực cho một việc lớn.\n\n'
        'Hãy phân bổ khôn ngoan: lương thực nuôi quân, quân lực giữ đất, '
        'và lòng dân là gốc rễ của tất cả.',
  ),
  Scene(
    id: 'a4_after_base',
    act: 4,
    title: 'Thành Bát Quái',
    location: 'Gia Định — 1790',
    text: 'Thành Gia Định mới mọc lên hình bát quái, tám cửa, tường cao, hào sâu. Đồn điền trải dài, '
        'xưởng đóng tàu ngày đêm vang tiếng búa. Gia Định đã thành một căn cứ đủ sức đối đầu với Tây Sơn.\n\n'
        'Trong ngục, hàng trăm tù binh Tây Sơn chờ phán quyết.',
    historyNote: 'Thành Gia Định (thành Bát Quái) được xây năm 1790, kết hợp kiểu Vauban với kiến trúc phương Đông, '
        'do Trần Văn Học vẽ họa đồ với sự tham gia của Olivier de Puymanel. Nguyễn Ánh còn cho lập đồn điền, '
        'đóng tàu, mở rộng giao thương.',
    choices: [
      Choice(
        text: 'Khoan hồng: cho tù binh gia nhập quân ngũ hoặc về quê làm ruộng',
        next: 'a4_end',
        effect: {'army': 8, 'morale': 5},
        setFlags: ['khoan_hong'],
        logLabel: 'Khoan hồng với tù binh Tây Sơn',
      ),
      Choice(
        text: 'Xử nghiêm để răn đe kẻ còn chống đối',
        next: 'a4_end',
        effect: {'morale': -8, 'army': 3},
        setFlags: ['nghiem_tri'],
        logLabel: 'Xử nghiêm tù binh Tây Sơn',
      ),
    ],
  ),
  Scene(
    id: 'a4_end',
    act: 4,
    title: 'Sét đánh ngang trời',
    location: 'Gia Định — 1792',
    text: 'Tin từ Phú Xuân bay vào như sét đánh: Hoàng đế Quang Trung — Nguyễn Huệ, kẻ thù lớn nhất, '
        'người chưa từng thua trận — đã đột ngột băng hà, khi mới 39 tuổi.\n\n'
        'Người kế vị, Cảnh Thịnh, chỉ là cậu bé mười tuổi.',
    choices: [
      Choice(text: 'Hồi 5 — Cuộc Chiến Với Tây Sơn', next: 'a5_start'),
    ],
  ),
];
