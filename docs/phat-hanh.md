# Hướng dẫn phát hành

## Bản Web (đã kiểm chứng)

```bash
cd gia_long_flutter
./scripts/build_web.sh
```

Script chạy `flutter analyze`, `flutter test`, build bản release, sửa `<base href>` cho phù hợp itch.io và đóng gói
`build/itch/gia-long-web.zip` (index.html nằm ở gốc file zip, khoảng 14 MB).

### Đăng lên itch.io

1. Tạo trang game mới trên itch.io → **Kind of project: HTML**.
2. Tải `gia-long-web.zip` lên, tick **This file will be played in the browser**.
3. Viewport gợi ý: **480 × 800** (hoặc bật *Fullscreen button* và *Mobile friendly*).
4. Lưu ý: game tải font (Noto Serif) và engine CanvasKit từ CDN của Google nên người chơi cần có mạng.

Chia sẻ trực tiếp không qua itch.io: giải nén zip lên bất kỳ web server tĩnh nào (GitHub Pages, Netlify...).

### Kiểm tra cục bộ trước khi đăng

```bash
cd gia_long_flutter/build/web && python3 -m http.server 8000   # rồi mở http://localhost:8000
```

## Bản Android (chưa kiểm chứng — cần Android SDK)

```bash
cd gia_long_flutter
flutter create --platforms=android --org vn.gialong .   # một lần, không ghi đè lib/
flutter build apk --release
```

File tạo ra: `build/app/outputs/flutter-apk/app-release.apk`. Để đăng Google Play cần ký ứng dụng
(xem https://docs.flutter.dev/deployment/android) — nên đặt lại `applicationId` và tên hiển thị trước.

## Danh sách kiểm tra trước khi phát hành

- [ ] Tự chơi hết một lượt từ Hồi 1 đến Hồi 6 (test tự động không thay được cảm nhận về nhịp truyện).
- [ ] Nhờ ít nhất 2–3 người ngoài chơi thử và ghi lại chỗ họ bị kẹt/khó hiểu.
- [ ] Rà lại các đoạn nhạy cảm ở Hồi 3 và kết thúc Hồi 6 (khoan dung / trả thù) với sử liệu.
- [ ] Thêm hình nền, chân dung, nhạc theo `gia_long_flutter/assets/README.md` và ghi nguồn vào `CREDITS.md`.
- [ ] Đổi `version` trong `pubspec.yaml` (hiện `0.1.0+1`).
