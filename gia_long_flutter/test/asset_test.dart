import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/services/asset_catalog.dart';
import 'package:gia_long_flutter/services/audio_service.dart';
import 'package:gia_long_flutter/story/asset_map.dart';
import 'package:gia_long_flutter/story/story_registry.dart';
import 'package:gia_long_flutter/widgets/scene_backdrop.dart';

void main() {
  test('ánh xạ asset chỉ trỏ tới cảnh và Hồi có thật', () {
    for (final id in [...sceneBackgrounds.keys, ...scenePortraits.keys]) {
      expect(sceneById.containsKey(id), isTrue, reason: 'cảnh "$id" không tồn tại');
    }
    for (var act = 1; act <= 6; act++) {
      expect(actBackgrounds[act], isNotNull, reason: 'thiếu hình nền Hồi $act');
      expect(actMusic[act], isNotNull, reason: 'thiếu nhạc Hồi $act');
    }
  });

  test('đường dẫn asset nằm trong các thư mục đã khai báo trong pubspec', () {
    for (final p in [...actBackgrounds.values, ...sceneBackgrounds.values]) {
      expect(p, startsWith('assets/images/backgrounds/'));
    }
    for (final p in scenePortraits.values) {
      expect(p, startsWith('assets/images/portraits/'));
    }
    for (final p in [...actMusic.values, battleMusic]) {
      expect(p, startsWith('audio/'));
    }
  });

  test('thiếu file asset thì game vẫn chạy: không lỗi, không phát nhạc', () async {
    expect(AssetCatalog.has('assets/audio/khong_co.mp3'), isFalse);
    await AudioService.instance.playMusic('audio/khong_co.mp3');
    await AudioService.instance.playMusic(null);
    await AudioService.instance.stop();
  });

  testWidgets('SceneBackdrop dựng được khi chưa có hình nền', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SceneBackdrop(scene: sceneById['a1_start']!, child: const Text('nội dung')),
    ));
    expect(find.text('nội dung'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}
