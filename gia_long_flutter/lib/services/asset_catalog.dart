import 'package:flutter/services.dart';

/// Danh sách asset thực sự có trong bản build.
///
/// Hình nền, chân dung và nhạc là tùy chọn: thiếu file thì game vẫn chạy bình thường
/// (dùng nền gradient, không chân dung, không nhạc) — nên trước khi dùng phải hỏi [has].
class AssetCatalog {
  static Set<String> _assets = {};

  static Future<void> load([AssetBundle? bundle]) async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(bundle ?? rootBundle);
      _assets = manifest.listAssets().toSet();
    } catch (_) {
      _assets = {};
    }
  }

  static bool has(String? path) => path != null && _assets.contains(path);
}
