# KẾ HOẠCH PHÁT TRIỂN CHI TIẾT
# GAME "GIA LONG: HÀNH TRÌNH THỐNG NHẤT"
### (Dựa trên cốt truyện Nguyễn Ánh — Vua Gia Long | Công nghệ: Flutter + VS Code)

---

## MỤC LỤC
1. Tổng quan dự án
2. Tóm tắt cốt truyện & cấu trúc 6 Hồi
3. Hệ thống quest chi tiết
4. Thiết kế hệ thống game (chỉ số, chiến đấu, lưu game)
5. Ngăn xếp công nghệ (Tech stack)
6. Môi trường phát triển & cài đặt
7. Cấu trúc project Flutter
8. Lộ trình phát triển theo giai đoạn (Roadmap)
9. Quy trình code hằng ngày với VS Code
10. Kế hoạch asset (hình ảnh, âm thanh)
11. Kiểm thử & phát hành
12. Rủi ro & cách giảm thiểu
13. Mốc thời gian tổng quan

---

## 1. TỔNG QUAN DỰ ÁN

| Hạng mục | Nội dung |
|---|---|
| Tên game (tạm) | Gia Long: Hành Trình Thống Nhất |
| Thể loại | Visual Novel / RPG nhẹ theo lựa chọn (choice-driven), có base-building nhẹ |
| Nền tảng | Web (Flutter Web) trước, mở rộng Android/iOS/Desktop sau — cùng 1 codebase |
| Ngôn ngữ lập trình | Dart (Flutter framework) |
| Công cụ code | VS Code + extension Flutter/Dart |
| Lưu trữ dữ liệu | `shared_preferences` (tương đương localStorage), không cần backend/database thật |
| Thời lượng chơi dự kiến | 6–10 tiếng (6 hồi chính + quest phụ) |
| Quy mô team tối thiểu | 1 người có thể làm được (kịch bản + code); có thêm người vẽ art sẽ nhanh hơn |

### Mục tiêu dự án
- Tái hiện hành trình 25 năm của Nguyễn Ánh (1777–1802) thành trải nghiệm chơi được
- Giữ tính giáo dục lịch sử, trình bày đa chiều ở giai đoạn gây tranh cãi (cầu viện phương Tây)
- Ưu tiên **hoàn thành một bản chơi được trọn vẹn** hơn là làm dở dang nhiều tính năng

---

## 2. TÓM TẮT CỐT TRUYỆN & CẤU TRÚC 6 HỒI

### HỒI 1: Sụp Đổ Và Chạy Trốn (1777)
Chúa Nguyễn Ánh, hoàng tôn trẻ tuổi của dòng họ Nguyễn ở Đàng Trong, chứng kiến quân Tây Sơn chiếm Gia Định, tàn sát gần hết dòng tộc. Ông chạy trốn ra đảo Thổ Chu, bắt đầu hành trình lưu vong.
**Xung đột chính:** mất tất cả — chỉ còn ý chí khôi phục cơ nghiệp.
**Đã có bản demo code:** scene `start` → `river`/`wait` → các nhánh kết thúc trong `story_data.dart`.

### HỒI 2: Những Năm Bôn Ba (1777–1787)
10 năm giằng co với Tây Sơn — nhiều lần chiếm rồi mất Gia Định. Từng tị nạn ở Xiêm La, thất bại nặng tại trận Rạch Gầm – Xoài Mút (1785) trước Nguyễn Huệ.
**Xung đột chính:** vòng lặp "được–mất" liên tục, tạo nhịp thăng trầm cho game.

### HỒI 3: Liên Minh Với Phương Tây (1787)
Cử Giám mục Bá Đa Lộc sang Pháp cầu viện cùng Hoàng tử Cảnh. Hiệp ước không được thực thi đầy đủ nhưng vẫn có được một số hỗ trợ quân sự.
**Xung đột chính:** nút thắt lịch sử nhạy cảm — cần trình bày đa chiều.

### HỒI 4: Tái Chiếm Gia Định (1788)
Lợi dụng lúc Nguyễn Huệ bận đối phó quân Thanh ở phía Bắc, Nguyễn Ánh tái chiếm Gia Định, xây dựng căn cứ vững chắc.
**Xung đột chính:** giai đoạn xây dựng — phù hợp cơ chế base-building nhẹ.

### HỒI 5: Cuộc Chiến Với Tây Sơn (1792–1801)
Sau khi Quang Trung mất đột ngột (1792), triều Tây Sơn suy yếu vì nội bộ. Nguyễn Ánh liên tục Bắc tiến, đánh chiếm Quy Nhơn, Phú Xuân.
**Xung đột chính:** chiến dịch quân sự dài nhất — chuỗi màn chiến đấu chính.

### HỒI 6: Thống Nhất Đất Nước (1802)
Đánh chiếm Thăng Long, tiêu diệt hoàn toàn Tây Sơn, lên ngôi lấy niên hiệu Gia Long, đặt quốc hiệu Việt Nam.
**Xung đột chính:** cao trào kết thúc — tổng kết hành trình 25 năm.

---

## 3. HỆ THỐNG QUEST CHI TIẾT

| Hồi | Quest chính | Quest phụ tiêu biểu | Cơ chế đặc trưng |
|---|---|---|---|
| 1 | Đêm Gia Định Thất Thủ | Tìm Đường Ra Biển | Escape sequence (đã code) |
| 2 | Vòng Lặp Được–Mất, Lưu Vong Xiêm La, Thảm Bại Rạch Gầm | — | Thất bại có kịch bản (scripted defeat) |
| 3 | Sứ Mệnh Cầu Viện | Chiêu Mộ Sĩ Quan Phương Tây, Góc Nhìn Đa Chiều (ẩn) | Quest dạng thư từ/ngoại giao |
| 4 | Trở Về Gia Định, Xây Dựng Căn Cứ | Ổn Định Lòng Dân | Base-building nhẹ (phân bổ tài nguyên) |
| 5 | Bắc Tiến (chuỗi: Hạ Quy Nhơn → Vây Phú Xuân → ...) | Khai Thác Nội Loạn Tây Sơn | Chuỗi trận đánh nối tiếp |
| 6 | Trận Thăng Long (final boss) | — | Multi-phase, cutscene kết + tổng kết lựa chọn |

**Cấu trúc dữ liệu quest (tham khảo cho code):**
```dart
class Quest {
  final String id;            // "Q3_CauVien"
  final int act;              // 3
  final String type;          // "main" | "side" | "hidden" | "event"
  final String unlockCondition; // "complete:Q2_end"
  final String reward;        // mô tả phần thưởng
}
```

---

## 4. THIẾT KẾ HỆ THỐNG GAME

### 4.1 Chỉ số nhân vật
- **Lương thực** — ảnh hưởng khả năng vượt qua các đoạn hành quân/base-building
- **Tinh thần** — ảnh hưởng lựa chọn đối thoại mở ra, kết cục nhánh
- (Mở rộng Hồi 4+) **Quân lực**, **Ngoại giao** — dùng cho base-building

### 4.2 Cơ chế chọn lựa (đã áp dụng từ Hồi 1)
Mỗi `Scene` có danh sách `Choice`, mỗi `Choice` dẫn tới `next` scene và có thể thay đổi chỉ số (`effect`). Đây là xương sống chạy xuyên suốt toàn bộ 6 hồi.

### 4.3 Hệ thống lưu game
- Dùng `shared_preferences`, lưu dạng JSON gồm: scene hiện tại, chỉ số, danh sách quest đã hoàn thành, lựa chọn quan trọng đã chọn (đặc biệt quest ẩn "Góc Nhìn Đa Chiều")
- Không cần backend/database — đúng với game single-player

### 4.4 Chiến đấu (cho Hồi 5, 6)
Đề xuất dạng **turn-based đơn giản** (dễ code bằng Flutter hơn real-time):
- Người chơi chọn hành động (Tấn công / Phòng thủ / Dùng kỹ năng) mỗi lượt
- Địch phản đòn theo kịch bản định sẵn (không cần AI phức tạp)

---

## 5. NGĂN XẾP CÔNG NGHỆ (TECH STACK)

| Lớp | Công nghệ | Vai trò |
|---|---|---|
| Ngôn ngữ | Dart | Toàn bộ logic + giao diện |
| Framework | Flutter | UI đa nền tảng |
| Lưu trữ local | `shared_preferences` | Save game (thay localStorage) |
| Font chữ | `google_fonts` (Noto Serif, Be Vietnam Pro) | Hỗ trợ tốt tiếng Việt có dấu |
| Âm thanh (khi thêm) | `audioplayers` | Nhạc nền, hiệu ứng |
| Quản lý state (khi project lớn) | `provider` hoặc `riverpod` | Thay `setState` khi có nhiều màn hình liên kết |
| Version control | Git | Lưu lịch sử code |

**Vì sao không cần Backend/Database thật:** game single-player, không có tính năng online (bảng xếp hạng, nhiều người chơi). Toàn bộ dữ liệu nằm trên máy người chơi.

---

## 6. MÔI TRƯỜNG PHÁT TRIỂN & CÀI ĐẶT

1. Cài **Flutter SDK** (docs.flutter.dev/get-started/install)
2. Cài **VS Code** + extension **Flutter** (tự kèm **Dart**)
3. Chạy `flutter doctor` để kiểm tra môi trường, sửa các mục báo lỗi
4. (Tùy chọn) Cài Chrome để test bản web nhanh nhất, không cần giả lập

---

## 7. CẤU TRÚC PROJECT FLUTTER

```
gia_long_flutter/
├── pubspec.yaml
├── lib/
│   ├── main.dart              # điểm khởi động, theme, cỡ chữ
│   ├── game/
│   │   ├── game_controller.dart  # luồng game: chuyển cảnh, chỉ số, quest, lưu
│   │   └── battle_engine.dart    # logic chiến đấu theo lượt (tách khỏi UI)
│   ├── story/
│   │   ├── act1_data.dart ... act6_data.dart  # cảnh + lựa chọn từng Hồi
│   │   ├── quests_data.dart / battles_data.dart / bases_data.dart
│   │   └── story_registry.dart   # gom toàn bộ dữ liệu, tra cứu theo id
│   ├── models/
│   │   ├── scene.dart, quest.dart, player_state.dart
│   │   └── battle.dart, base_building.dart
│   ├── services/
│   │   └── save_service.dart  # lưu/đọc bằng shared_preferences
│   ├── screens/
│   │   ├── main_menu_screen.dart, game_screen.dart, quest_log_screen.dart
│   │   ├── battle_screen.dart, base_screen.dart, ending_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
│       ├── choice_button.dart
│       ├── stat_chip.dart
│       └── scene_card.dart
├── assets/                    # (chưa tạo — thêm ở Giai đoạn 4)
│   ├── images/
│   └── audio/
└── test/                      # kiểm tra dữ liệu story, chiến đấu, luồng game, UI
```

**Nguyên tắc:** khi `story_data.dart` vượt ~300 dòng → tách theo từng Hồi (`act1_data.dart`, `act2_data.dart`...). Khi `main.dart` phình to → tách UI thành `screens/` và `widgets/` riêng (đã bắt đầu áp dụng ở cấu trúc trên).

---

## 8. LỘ TRÌNH PHÁT TRIỂN THEO GIAI ĐOẠN

> Ký hiệu: `[x]` xong · `[~]` phần code xong, chờ nội dung/asset từ bạn · `[ ]` chưa làm.

### GIAI ĐOẠN 0 — Tiền sản xuất (2–3 tuần)
- [x] Chốt cốt truyện 6 hồi
- [x] Chốt hệ thống quest tổng quan
- [x] Chọn công nghệ: Flutter + VS Code
- [x] Dựng khung code Hồi 1 (đã có: `main.dart`, `story_data.dart`, `save_service.dart`)
- [x] Vẽ sơ đồ luồng game tổng thể (flow chart) từ Hồi 1 → Hồi 6 (xem `docs/so-do-luong-game.md`)

### GIAI ĐOẠN 1 — Hoàn thiện khung kỹ thuật (2–3 tuần)
- [x] Tách `story_data.dart` thành cấu trúc `story/act1_data.dart` v.v.
- [x] Tạo `models/quest.dart`, `models/player_state.dart`
- [x] Xây `screens/main_menu_screen.dart` (màn hình chính: Chơi mới / Tiếp tục / Cài đặt)
- [x] Xây `screens/quest_log_screen.dart` cơ bản

### GIAI ĐOẠN 2 — Nội dung Hồi 1–3 (2–3 tháng)
- [x] Hoàn thiện toàn bộ scene + lựa chọn Hồi 1 (mở rộng thêm nhánh ngoài demo hiện có: xóm chài Hà Tiên, đêm binh sĩ muốn bỏ trốn)
- [x] Viết Hồi 2: cơ chế "vòng lặp được–mất", trận Rạch Gầm (thất bại có kịch bản)
- [x] Viết Hồi 3: quest ngoại giao, quest ẩn "Góc Nhìn Đa Chiều"
- [x] Gắn hệ thống quest vào từng scene tương ứng

### GIAI ĐOẠN 3 — Nội dung Hồi 4–6 (2–3 tháng)
- [x] Xây cơ chế base-building nhẹ cho Hồi 4 (màn hình phân bổ tài nguyên)
- [x] Viết chuỗi trận Bắc Tiến Hồi 5 (turn-based combat cơ bản)
- [x] Viết trận Thăng Long (Hồi 6) — boss multi-phase
- [x] Cutscene kết + màn hình tổng kết lựa chọn người chơi

### GIAI ĐOẠN 4 — Asset hình ảnh & âm thanh (2–4 tuần, làm song song)
- [~] Thêm hình nền từng bối cảnh (Gia Định, Xiêm La, Phú Xuân, Thăng Long...) — hệ thống đã sẵn sàng, **chờ file ảnh**, xem `gia_long_flutter/assets/README.md`
- [~] Thêm chân dung nhân vật chính (Nguyễn Ánh, Bá Đa Lộc, tướng lĩnh) — hệ thống đã sẵn sàng, **chờ file ảnh**
- [~] Thêm nhạc nền theo từng Hồi, hiệu ứng âm thanh lựa chọn/chiến đấu — nhạc nền theo Hồi/trận đánh đã sẵn sàng (có công tắc trong Cài đặt), **chờ file nhạc**; chưa có hiệu ứng âm thanh

### GIAI ĐOẠN 5 — Kiểm thử & tinh chỉnh (3–4 tuần)
- [x] Chơi thử toàn bộ từ đầu đến cuối tất cả các nhánh chính (mô phỏng 2000 ván ngẫu nhiên: `test/coverage_test.dart`; bạn vẫn nên tự chơi thử ít nhất một lượt)
- [x] Sửa lỗi, cân bằng chỉ số/độ khó (đã chỉnh trận Quy Nhơn/Thị Nại; trận Thăng Long cần quân lực ≥ 30)
- [ ] Nhờ người ngoài chơi thử, lấy phản hồi khách quan *(việc của bạn)*

### GIAI ĐOẠN 6 — Phát hành (1–2 tuần)
- [x] Build bản Web (`flutter build web`) để chia sẻ link chơi thử (`gia_long_flutter/scripts/build_web.sh` → zip cho itch.io)
- [~] (Tùy chọn) Build Android (`flutter build apk`) — hướng dẫn trong `docs/phat-hanh.md`, chưa build được vì máy chưa có Android SDK
- [~] Đăng lên itch.io hoặc chia sẻ trực tiếp link web — gói zip và hướng dẫn đã sẵn sàng (`docs/phat-hanh.md`), **cần tài khoản của bạn để đăng**

---

## 9. QUY TRÌNH CODE HẰNG NGÀY VỚI VS CODE

```
1. Mở VS Code → File > Open Folder → chọn gia_long_flutter/
2. Terminal (Ctrl+`) → flutter pub get (khi vừa thêm package mới)
3. Chọn thiết bị (góc dưới phải) → Chrome (nhanh nhất để test)
4. F5 hoặc Run → chờ build lần đầu
5. Sửa code → nhấn "r" (Hot Reload) để xem ngay
6. Đổi cấu trúc lớn (thêm class, đổi state) → nhấn "R" (Hot Restart)
7. Kết thúc buổi code → git add . && git commit -m "mô tả thay đổi"
```

**Debug:**
- Breakpoint: click lề trái dòng code
- Debug Console: xem log, `debugPrint()`
- Flutter Inspector: xem cây widget khi layout bị lỗi

---

## 10. KẾ HOẠCH ASSET

| Loại | Nguồn/công cụ | Ghi chú |
|---|---|---|
| Concept nhân vật | Leonardo AI / Midjourney | Cần chỉnh sửa kỹ trang phục cho đúng thời Nguyễn (dễ lẫn phong cách Trung Quốc/Nhật nếu dùng AI) |
| Chỉnh sửa/tách nền | Krita (miễn phí) / Photoshop | Đưa concept AI thành asset dùng được trong game |
| Bối cảnh | Krita hoặc AI + chỉnh sửa | Gia Định, Xiêm La, Phú Xuân, Thăng Long |
| Âm nhạc | Tìm nhạc cung đình/dân tộc không bản quyền, hoặc đặt sáng tác riêng | Ưu tiên nhạc cụ dân tộc giữ chất lịch sử |

---

## 11. KIỂM THỬ & PHÁT HÀNH

- **Kiểm thử chức năng:** chơi hết mọi nhánh, đảm bảo save/load không lỗi qua nhiều lần tắt mở
- **Kiểm thử nội dung:** rà lại các đoạn lịch sử nhạy cảm (Hồi 3) đã trình bày đa chiều chưa
- **Build phát hành:**
  ```
  flutter build web          # bản chạy trên trình duyệt
  flutter build apk          # bản Android (tùy chọn)
  ```
- **Kênh phát hành:** itch.io (phù hợp indie, hỗ trợ tốt bản web), hoặc chia sẻ link web trực tiếp

---

## 12. RỦI RO & CÁCH GIẢM THIỂU

| Rủi ro | Cách giảm thiểu |
|---|---|
| Nội dung lịch sử nhạy cảm (cầu viện ngoại bang) gây tranh cãi | Trình bày đa chiều, tách phần "thông tin lịch sử thật" riêng khỏi diễn giải trong game |
| Khối lượng công việc lớn, dễ nản giữa chừng | Đã có prototype Hồi 1 chạy được — tiếp tục theo từng Giai đoạn nhỏ, không làm dồn toàn bộ |
| Thiếu asset đúng trang phục/bối cảnh lịch sử Việt Nam | Dành thời gian nghiên cứu tư liệu (tranh dân gian, sử liệu) trước khi vẽ/tạo AI |
| `story_data.dart`/`main.dart` phình to khó quản lý | Áp dụng cấu trúc tách file theo Hồi và theo screens/widgets/models ngay từ Giai đoạn 1 |
| State phức tạp dần khi thêm quest/inventory | Chuyển sang `provider`/`riverpod` khi `setState` không còn đủ |

---

## 13. MỐC THỜI GIAN TỔNG QUAN

```
Tuần 1-3     Tuần 4-6      Tuần 7-18          Tuần 19-30         Tuần 31-34        Tuần 35-38      Tuần 39-40
[Tiền SX] -> [Khung KT] -> [ND Hồi 1-3]  -> [ND Hồi 4-6]  -> [Asset]        -> [Test/Tinh chỉnh] -> [Phát hành]
```

Tổng thời gian dự kiến: **khoảng 9–10 tháng** nếu làm bán thời gian một mình; rút ngắn còn 4–5 tháng nếu có thêm người vẽ art hỗ trợ song song.

---

## PHỤ LỤC: FILE CODE ĐÃ CÓ (khởi điểm Giai đoạn 0–1)

- `lib/main.dart` — giao diện + logic Hồi 1 demo
- `lib/story_data.dart` — dữ liệu cảnh Hồi 1 (cần tách thành `story/act1_data.dart` ở Giai đoạn 1)
- `lib/save_service.dart` — lưu tiến trình bằng `shared_preferences`
- `pubspec.yaml` — khai báo `shared_preferences`, `google_fonts`

---

*Tài liệu này là kế hoạch tổng hợp đầy đủ — cập nhật lại checklist sau mỗi giai đoạn hoàn thành thực tế.*
