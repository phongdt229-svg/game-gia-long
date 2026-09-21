# Asset cho game

Game **chạy bình thường khi thiếu file** ở đây: thiếu hình nền thì dùng nền gradient theo Hồi, thiếu chân dung thì không hiện, thiếu nhạc thì im lặng. Chỉ cần đặt file đúng **tên** và **thư mục** bên dưới, game tự nhận (không cần sửa code). Đổi/ thêm ánh xạ ở `lib/story/asset_map.dart`.

> Chưa có asset? Xem **[docs/prompt-tao-asset.md](../../docs/prompt-tao-asset.md)** — prompt viết sẵn cho từng file để dùng với các AI tạo ảnh/nhạc.

Sau khi thêm file: `flutter pub get` không cần chạy lại, nhưng phải **Hot Restart** (`R`) hoặc chạy lại app vì danh sách asset đọc lúc khởi động.

## Hình nền — `images/backgrounds/`

Ảnh ngang, khuyến nghị 1920×1080, JPG chất lượng ~80% (nhẹ cho bản web). Game phủ thêm lớp tối 60% để dễ đọc chữ.

| File | Dùng cho |
|---|---|
| `act1_gia_dinh.jpg` | Hồi 1 (Gia Định, đêm thất thủ, kênh rạch) |
| `act2_xiem_la.jpg` | Hồi 2 (lưu vong, Xiêm La, sông Tiền) |
| `act3_phuong_tay.jpg` | Hồi 3 (cầu viện, thư từ, triều đình) |
| `act4_can_cu.jpg` | Hồi 4 (Gia Định, thành Bát Quái, đồn điền) |
| `act5_bac_tien.jpg` | Hồi 5 (Quy Nhơn, Thị Nại, hành quân) |
| `act6_thang_long.jpg` | Hồi 6 (Thăng Long, hoàng cung) |
| `dao_tho_chu.jpg` | Cảnh riêng: đảo Thổ Chu (`a1_island`) |
| `phu_xuan.jpg` | Cảnh riêng: Phú Xuân (`a5_phuxuan`) |
| `thang_long.jpg` | Cảnh riêng: cờ trên thành Thăng Long (`a6_victory`) |

## Chân dung — `images/portraits/`

PNG nền trong suốt, vuông (khuyến nghị 512×512), hiện dạng hình tròn cạnh tiêu đề cảnh.

| File | Nhân vật | Cảnh |
|---|---|---|
| `nguyen_anh.png` | Nguyễn Ánh (thời trẻ / trung niên) | `a1_start`, `a1_oath`, `a6_victory` |
| `ba_da_loc.png` | Giám mục Bá Đa Lộc | `a1_mangrove`, `a3_start` |
| `hoang_tu_canh.png` | Hoàng tử Cảnh | `a3_prince` |
| `vo_tanh.png` | Võ Tánh | `a5_quynhon_won` |
| `gia_long.png` | Gia Long (lên ngôi) | `a6_epilogue` |

## Nhạc — `audio/`

MP3 (hoặc định dạng `audioplayers` hỗ trợ), phát lặp. Nên dùng nhạc cụ dân tộc / cung đình, dung lượng mỗi bài dưới ~3 MB cho bản web.

| File | Dùng cho |
|---|---|
| `act1_luu_vong.mp3` … `act6_thong_nhat.mp3` | Nhạc nền từng Hồi (xem tên đầy đủ trong `asset_map.dart`) |
| `battle.mp3` | Mọi cảnh chiến đấu |

## Lưu ý nguồn và bản quyền

- Chỉ dùng nhạc/hình **không bản quyền** hoặc do bạn tự làm/đặt sáng tác; ghi nguồn và giấy phép vào file `CREDITS.md` khi phát hành lên itch.io.
- Ảnh do AI tạo dễ lẫn trang phục kiểu Trung Quốc/Nhật: đối chiếu với tranh dân gian và sử liệu thời Nguyễn trước khi dùng (xem mục 10 trong kế hoạch).
