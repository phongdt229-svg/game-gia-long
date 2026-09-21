# Bộ prompt tạo asset bằng AI

Mỗi mục bên dưới ứng với **một file** trong `gia_long_flutter/assets/` (tên file, thư mục và kích thước theo `assets/README.md`).
Prompt viết bằng tiếng Anh vì các công cụ tạo ảnh/nhạc hiểu tốt hơn; phần "Ghi chú" bằng tiếng Việt là để bạn kiểm tra kết quả.

## Cách làm chung

1. Chọn **một** công cụ ảnh và dùng suốt cho cả bộ để phong cách đồng nhất (gợi ý: Leonardo AI, Bing Image Creator, Gemini, ChatGPT).
2. Luôn dán **"Khối phong cách"** dưới đây vào cuối mỗi prompt ảnh.
3. Tạo 3–4 biến thể mỗi ảnh, chọn cái đúng nhất. Kiểm tra trang phục bằng tranh dân gian / tư liệu thời Nguyễn trên Wikimedia Commons.
4. Đổi tên đúng như bảng, bỏ vào đúng thư mục, rồi **Hot Restart** (`R`) — không cần sửa code.
5. Ghi công cụ, ngày tạo, giấy phép vào `gia_long_flutter/CREDITS.md`. Khi đăng itch.io nhớ khai báo game có nội dung do AI tạo.

### Khối phong cách (dán vào cuối mọi prompt ảnh)

```
Style: painterly historical illustration, muted earthy palette with warm gold and deep red accents,
soft cinematic lighting, subtle film grain, inspired by 18th-century Vietnamese folk painting and lacquer art,
historically grounded, no text, no watermark, no logo, no modern objects.
```

### Negative prompt (nếu công cụ có ô riêng)

```
Chinese dynasty costume, Japanese samurai armor, kimono, anime style, cartoon, modern clothing, text, watermark,
signature, extra limbs, deformed hands, blurry, low resolution
```

### Lưu ý trang phục thời Nguyễn (AI hay sai chỗ này)

- Nam giới: **áo giao lĩnh / áo dài the** cổ tròn hoặc cổ đứng, quần rộng, **khăn đóng** hoặc nón; quân phục là áo giáp vải/da có mảnh kim loại, **không** phải giáp Nhật hay Trung Hoa.
- Vua: **áo bào vàng** thêu rồng, mũ có cánh chuồn (kiểu Nguyễn), không phải mũ miện Trung Hoa với tua rèm.
- Thuyền: thuyền buồm cánh dơi / ghe bầu Nam Bộ, thuyền chiến Việt; tàu Tây là **tàu buồm ba cột châu Âu thế kỷ 18**.

---

## A. Hình nền — `assets/images/backgrounds/` (ngang 16:9, xuất 1920×1080, JPG)

Game phủ lớp tối 60% lên ảnh nên hãy chọn ảnh **tối và ít chi tiết ở giữa**, để chữ vẫn dễ đọc.

### `act1_gia_dinh.jpg` — Hồi 1 (Gia Định thất thủ, kênh rạch)
```
Night scene of a burning 18th-century Vietnamese citadel on a river, red glow of fires against a dark blue sky,
smoke rising, silhouettes of soldiers on the walls, small boats fleeing along a mangrove canal in the foreground,
1777 Gia Dinh, wide cinematic composition.
```
Ghi chú: cảnh đêm, có lửa, có kênh rạch/rừng đước. Không có súng hiện đại.

### `act2_xiem_la.jpg` — Hồi 2 (lưu vong Xiêm La, sông Tiền)
```
Dusk on a broad tropical river in the 1780s, distant Thai Buddhist temple spires with tiered roofs on the bank,
a small camp of Vietnamese exiles with simple thatched shelters, war junks anchored, golden hour haze,
melancholic mood of exile, wide cinematic composition.
```
Ghi chú: có chùa tháp Thái Lan ở xa, tâm trạng buồn, lưu vong.

### `act3_phuong_tay.jpg` — Hồi 3 (cầu viện, thư từ, ngoại giao)
```
Candlelit study in the 1780s, a table with handwritten letters, quill and ink, an old map of Southeast Asia,
a small model of a European three-masted sailing ship, a folding screen with Vietnamese motifs behind,
warm candlelight and deep shadows, sense of secret diplomacy, no people.
```
Ghi chú: không có người để khỏi sai gương mặt; có bản đồ, thư, mô hình tàu Tây.

### `act4_can_cu.jpg` — Hồi 4 (thành Bát Quái, đồn điền)
```
Aerial view at sunrise of an octagonal star-shaped citadel in the Vauban style with a lotus-filled moat and eight gates,
surrounded by green rice fields and a shipyard on a wide river, Gia Dinh 1790,
peaceful rebuilding after war, warm morning light.
```
Ghi chú: thành hình bát quái/hình sao kiểu Vauban, hào sen, đồn điền, xưởng đóng tàu.

### `act5_bac_tien.jpg` — Hồi 5 (Quy Nhơn, Thị Nại, hành quân)
```
A fleet of Vietnamese war junks with tan sails advancing along a stormy coast toward a walled coastal city,
monsoon clouds, dramatic sea, banners with yellow flags, 1799–1801 naval campaign,
sense of a long war, dark and dramatic sky.
```
Ghi chú: thuyền chiến Việt buồm nâu, biển động, thành ven biển.

### `act6_thang_long.jpg` — Hồi 6 (Thăng Long, hoàng cung)
```
Dawn over the ancient citadel of Thang Long in 1802, a large stone gate with a tiled tower, war elephants at the gate,
yellow banners, mist over the Red River in the distance, epic and solemn atmosphere.
```
Ghi chú: cổng thành cổ, voi chiến, cờ vàng. **Không** vẽ Cột cờ Hà Nội hay tháp Rùa (xây sau thời điểm này).

### `dao_tho_chu.jpg` — cảnh riêng: đảo Thổ Chu
```
A remote tropical island at night, dark beach with a small campfire, a few battered wooden boats pulled onto the sand,
starry sky, calm sea, a few silhouettes sitting around the fire, lonely and hopeful mood, 1770s Vietnam.
```

### `phu_xuan.jpg` — cảnh riêng: Phú Xuân
```
Spring morning in the citadel city of Phu Xuan by the Perfume River, low mist on the water, tiled roofs and ramparts,
sampans on the river, solemn atmosphere of return and loss, 1801.
```

### `thang_long.jpg` — cảnh riêng: cờ trên thành Thăng Long
```
Yellow banners flying above the walls of Thang Long citadel at sunrise after a battle, smoke drifting,
fallen banners on the ground in the foreground, triumphant but somber mood, 1802.
```

---

## B. Chân dung — `assets/images/portraits/` (vuông, 512×512, PNG nền trong suốt)

Game hiển thị chân dung **hình tròn** cạnh tiêu đề, nên hãy để khuôn mặt **ở giữa, gần khung hình** (ảnh chân dung ngực trở lên).

**Nền trong suốt:** AI thường không xuất được. Cách làm: thêm vào prompt `plain solid light gray background`, tạo xong dùng **remove.bg**, **Photopea** hoặc **Krita** để xóa nền, xuất PNG. (Nếu bạn để nguyên nền phẳng cũng được — game vẫn cắt tròn.)

Dán thêm "Khối phong cách" và Negative prompt như trên.

### `nguyen_anh.png` — Nguyễn Ánh
```
Bust portrait of Nguyen Anh as a determined young man in his twenties, 1780s Vietnam, calm resolute expression,
simple dark ao giao linh robe with a small dark turban (khan dong), plain solid light gray background, front-facing, centered.
```
Ghi chú: ảnh này dùng cho cả Hồi 1 (khi ông mới 15 tuổi) và Hồi 6. Nếu muốn chính xác hơn, tạo thêm bản trẻ hơn và bản trung niên rồi báo mình để tách thành hai file.

### `ba_da_loc.png` — Giám mục Bá Đa Lộc (Pigneau de Behaine)
```
Bust portrait of a French Catholic bishop in his forties, 1780s, graying hair, kind but shrewd expression,
simple black cassock with a pectoral cross, weathered face from tropical travel, plain solid light gray background, front-facing, centered.
```
Ghi chú: người Pháp, áo chùng đen, thánh giá trước ngực, gương mặt phong trần.

### `hoang_tu_canh.png` — Hoàng tử Cảnh
```
Portrait of a Vietnamese royal child aged about seven, 1780s, dressed in a small formal silk robe with a modest cap,
calm and dignified expression for a child, plain solid light gray background, front-facing, centered.
```
Ghi chú: trẻ khoảng 4–7 tuổi (Hoàng tử Cảnh sinh năm 1780). Trang phục Việt, không phải kiểu Trung Hoa.

### `vo_tanh.png` — Võ Tánh
```
Bust portrait of a loyal Vietnamese general in his thirties, late 18th century, stern honorable expression,
traditional cloth-and-leather armor with metal plates and a dark cloth headband, plain solid light gray background, front-facing, centered.
```
Ghi chú: giáp thời Nguyễn, không phải giáp samurai.

### `gia_long.png` — Vua Gia Long lúc lên ngôi
```
Bust portrait of the Vietnamese emperor Gia Long at about forty, 1802, dignified and weary expression,
golden-yellow imperial robe embroidered with dragons, Nguyen-style imperial hat with winged sides,
plain solid light gray background, front-facing, centered.
```
Ghi chú: áo bào vàng thêu rồng, mũ cánh chuồn kiểu Nguyễn. Có thể tham khảo chân dung vua Gia Long trên Wikimedia Commons để chỉnh cho đúng.

---

## C. Nhạc nền — `assets/audio/` (MP3, lặp được, 2–3 phút, dưới ~3 MB)

Dùng Suno / Udio / Stable Audio. Ở Suno hãy bật **Instrumental**. Ô "Style of music" điền như dưới; nếu có ô lời thì để trống.
Nên chọn bản **không có đoạn kết dứt khoát** (để lặp mượt). Nén về ~128 kbps bằng Audacity hoặc ffmpeg nếu file quá nặng:
`ffmpeg -i in.mp3 -b:a 112k out.mp3`

| File | Style of music (dán vào công cụ) | Cảm giác |
|---|---|---|
| `act1_luu_vong.mp3` | `Vietnamese traditional instrumental, dan tranh and dan nhi, slow, melancholic, night, sparse, cinematic, no vocals` | Bơ vơ, chạy trốn trong đêm |
| `act2_bon_ba.mp3` | `Vietnamese folk instrumental with bamboo flute (sao truc) and dan bau, wandering, wistful, gentle rhythm, no vocals` | Lưu lạc, bôn ba, nhớ quê |
| `act3_su_menh.mp3` | `Vietnamese traditional instruments blended with soft harpsichord and strings, diplomatic, mysterious, restrained, no vocals` | Ngoại giao, bí mật, giằng xé |
| `act4_can_cu.mp3` | `Vietnamese traditional instrumental, dan tranh, warm and hopeful, steady mid-tempo, rebuilding, pastoral, no vocals` | Dựng lại, hy vọng |
| `act5_bac_tien.mp3` | `Cinematic Vietnamese war music, deep war drums (trong), dan nhi, rising tension, marching rhythm, epic, no vocals` | Hành quân, chiến tranh dài |
| `act6_thong_nhat.mp3` | `Vietnamese royal court music (nha nhac) inspired, majestic, solemn, gongs, dan tranh and orchestral strings, triumphant yet bittersweet, no vocals` | Uy nghi, thống nhất, xúc động |
| `battle.mp3` | `Fast aggressive Vietnamese war drums (trong tran), dan nhi, urgent percussion, intense, loopable, no vocals` | Căng thẳng, dồn dập (dùng cho mọi trận đánh) |

Ghi chú: tên bài không cần khớp chính xác tên nhạc cụ — AI hiểu "dan tranh / dan nhi / sao truc" khá ổn nhưng đôi lúc nghe ra nhạc Trung Hoa. Nghe kỹ, nếu lệch quá thì thêm `Vietnamese, not Chinese, not Japanese` vào prompt hoặc thử lại.

---

## D. Kiểm tra sau khi bỏ file vào

1. Đúng thư mục và **đúng tên file** (phân biệt hoa/thường): xem cột tên trong `assets/README.md`.
2. Ảnh nền **JPG** ≤ ~400 KB mỗi ảnh; chân dung PNG ≤ ~300 KB; nhạc ≤ ~3 MB (bản web tải về càng nhẹ càng tốt). Có thể nén ảnh bằng squoosh.app.
3. Chạy lại app (Hot Restart). Cảnh nào có ảnh sẽ hiện nền; nhạc phát ngay khi vào màn chơi (bật/tắt trong **Cài đặt**).
4. Nếu chữ khó đọc trên ảnh sáng, chọn lại ảnh tối hơn — lớp phủ hiện cố định 60%.
5. Cập nhật `CREDITS.md`, tick lại mục Giai đoạn 4 trong file kế hoạch.
