import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'asset_catalog.dart';

/// Phát nhạc nền lặp lại. Thiếu file nhạc hoặc lỗi thiết bị thì im lặng bỏ qua.
class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  AudioPlayer? _player;
  String? _current;
  bool _enabled = true;

  bool get enabled => _enabled;

  /// [track] tính từ thư mục `assets/`, ví dụ `audio/act1.mp3`; `null` = dừng nhạc.
  Future<void> playMusic(String? track) async {
    if (track == null || !_enabled) {
      if (track == null) await stop();
      return;
    }
    if (_current == track) return;
    if (!AssetCatalog.has('assets/$track')) {
      await stop();
      return;
    }
    _current = track;
    try {
      final player = _player ??= AudioPlayer()..setReleaseMode(ReleaseMode.loop);
      await player.play(AssetSource(track), volume: 0.5);
    } catch (e) {
      debugPrint('Không phát được nhạc "$track": $e');
    }
  }

  Future<void> stop() async {
    _current = null;
    try {
      await _player?.stop();
    } catch (e) {
      debugPrint('Không dừng được nhạc: $e');
    }
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    if (!value) await stop();
  }
}
