import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gia_long_flutter/game/game_controller.dart';
import 'package:gia_long_flutter/models/player_state.dart';
import 'package:gia_long_flutter/screens/game_screen.dart';
import 'package:gia_long_flutter/screens/main_menu_screen.dart';
import 'package:gia_long_flutter/services/save_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  /// Màn hình dọc đủ cao để mọi nút đều nằm trong khung nhìn.
  void useTallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  /// Chờ SnackBar thông báo biến mất để không che nút bên dưới.
  Future<void> settleNotices(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
  }

  Future<void> pumpMenu(WidgetTester tester, SaveService save) {
    return tester.pumpWidget(MaterialApp(
      home: MainMenuScreen(save: save, textScale: ValueNotifier(1.0)),
    ));
  }

  testWidgets('menu: chưa có bản lưu thì "Tiếp tục" bị khóa; Chơi mới vào Hồi 1 và chọn được', (tester) async {
    useTallScreen(tester);
    final save = SaveService();
    await pumpMenu(tester, save);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Tiếp tục')).onPressed, isNull);

    await tester.tap(find.text('Chơi mới'));
    await tester.pumpAndSettle();
    expect(find.text('Đêm Gia Định thất thủ'), findsOneWidget);

    await tester.tap(find.textContaining('Mở kho lương'));
    await tester.pumpAndSettle();
    expect(find.text('Kho lương mở cửa'), findsOneWidget);

    // Quay về menu: bản lưu đã có nên "Tiếp tục" mở được.
    await settleNotices(tester);
    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Về màn hình chính'));
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Tiếp tục')).onPressed, isNotNull);

    await tester.tap(find.text('Tiếp tục'));
    await tester.pumpAndSettle();
    expect(find.text('Kho lương mở cửa'), findsOneWidget);
  });

  testWidgets('cảnh chiến đấu: ra trận, chơi tới hết và quay lại cảnh kế tiếp', (tester) async {
    useTallScreen(tester);
    final controller = GameController.newGame(SaveService())
      ..state.stats.addAll({'army': 60, 'food': 60, 'morale': 60})
      ..goTo('a5_quynhon');
    await tester.pumpWidget(MaterialApp(home: GameScreen(controller: controller)));
    await tester.pumpAndSettle();

    await settleNotices(tester);
    await tester.tap(find.text('Ra trận'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Địch chuẩn bị'), findsOneWidget);

    var guard = 0;
    while (find.text('Tiếp tục').evaluate().isEmpty && guard++ < 60) {
      await tester.tap(find.text('Tấn công'));
      await tester.pump();
    }
    await tester.tap(find.text('Tiếp tục'));
    await tester.pumpAndSettle();
    expect(controller.scene.id, anyOf('a5_quynhon_won', 'a5_regroup_qn'));
  });

  testWidgets('cảnh căn cứ: phân bổ đủ mùa vụ rồi hoàn tất', (tester) async {
    useTallScreen(tester);
    final controller = GameController.newGame(SaveService())..goTo('a4_base');
    await tester.pumpWidget(MaterialApp(home: GameScreen(controller: controller)));
    await tester.pumpAndSettle();

    await settleNotices(tester);
    await tester.tap(find.text('Bắt tay xây dựng'));
    await tester.pumpAndSettle();
    for (var i = 0; i < 6; i++) {
      await tester.tap(find.text('Luyện binh'));
      await tester.pump();
    }
    await tester.tap(find.text('Hoàn tất'));
    await tester.pumpAndSettle();
    expect(controller.scene.id, 'a4_after_base');
    expect(controller.state.stat('army'), greaterThan(PlayerState.initialStats['army']!));
  });

  testWidgets('cảnh kết thúc mở màn hình tổng kết', (tester) async {
    useTallScreen(tester);
    final controller = GameController.newGame(SaveService())..goTo('a6_epilogue');
    await tester.pumpWidget(MaterialApp(home: GameScreen(controller: controller)));
    await tester.pumpAndSettle();
    await settleNotices(tester);
    await tester.tap(find.text('Xem tổng kết hành trình'));
    await tester.pumpAndSettle();
    expect(find.text('Tổng kết hành trình'), findsOneWidget);
  });
}
