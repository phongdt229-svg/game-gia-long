#!/usr/bin/env bash
# Build bản web và đóng gói zip để tải lên itch.io (HTML5 game).
# Dùng: ./scripts/build_web.sh   (chạy từ thư mục gia_long_flutter/, cần `flutter` trong PATH)
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> Kiểm tra mã nguồn và chạy test"
flutter analyze
flutter test

echo "==> Build web"
flutter build web --release

# itch.io phục vụ game từ một đường dẫn con nên phải dùng đường dẫn tương đối.
# (Flutter không nhận --base-href ./ nên sửa thẻ <base> sau khi build.)
grep -q '<base href="/">' build/web/index.html || { echo "Không thấy <base href=\"/\"> trong index.html"; exit 1; }
sed -i 's|<base href="/">|<base href="./">|' build/web/index.html

OUT=build/itch
rm -rf "$OUT" && mkdir -p "$OUT"
ZIP="$OUT/gia-long-web.zip"
if command -v zip >/dev/null 2>&1; then
  (cd build/web && zip -qr "../../$ZIP" .)
else
  python3 - "$ZIP" <<'PY'
import os, sys, zipfile
with zipfile.ZipFile(sys.argv[1], "w", zipfile.ZIP_DEFLATED) as z:
    for root, _, files in os.walk("build/web"):
        for f in files:
            p = os.path.join(root, f)
            z.write(p, os.path.relpath(p, "build/web"))
PY
fi

echo "==> Xong: $ZIP ($(du -h "$ZIP" | cut -f1)). index.html nằm ở gốc file zip."
