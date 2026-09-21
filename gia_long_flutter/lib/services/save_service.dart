import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/player_state.dart';

/// Lưu/đọc tiến trình game bằng `shared_preferences` (không cần backend).
class SaveService {
  static const _saveKey = 'gia_long_save_v1';
  static const _textScaleKey = 'gia_long_text_scale';
  static const _musicKey = 'gia_long_music_enabled';

  Future<bool> hasSave() async => (await SharedPreferences.getInstance()).containsKey(_saveKey);

  Future<void> save(PlayerState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_saveKey, jsonEncode(state.toJson()));
  }

  /// Trả về `null` nếu chưa có bản lưu hoặc bản lưu bị hỏng.
  Future<PlayerState?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_saveKey);
    if (raw == null) return null;
    try {
      return PlayerState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_saveKey);
  }

  Future<double> loadTextScale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_textScaleKey) ?? 1.0;
  }

  Future<bool> loadMusicEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_musicKey) ?? true;
  }

  Future<void> saveMusicEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicKey, enabled);
  }

  Future<void> saveTextScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_textScaleKey, scale);
  }
}
