import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/main_menu_screen.dart';
import 'services/save_service.dart';

void main() => runApp(const GiaLongApp());

class GiaLongApp extends StatefulWidget {
  const GiaLongApp({super.key});

  @override
  State<GiaLongApp> createState() => _GiaLongAppState();
}

class _GiaLongAppState extends State<GiaLongApp> {
  final _save = SaveService();
  final _textScale = ValueNotifier<double>(1.0);

  @override
  void initState() {
    super.initState();
    _save.loadTextScale().then((v) => _textScale.value = v);
  }

  @override
  void dispose() {
    _textScale.dispose();
    super.dispose();
  }

  ThemeData _theme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFB8860B),
        brightness: Brightness.dark,
      ),
    );
    return base.copyWith(textTheme: GoogleFonts.notoSerifTextTheme(base.textTheme));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gia Long: Hành Trình Thống Nhất',
      debugShowCheckedModeBanner: false,
      theme: _theme(),
      builder: (context, child) => ValueListenableBuilder<double>(
        valueListenable: _textScale,
        builder: (context, scale, _) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
      ),
      home: MainMenuScreen(save: _save, textScale: _textScale),
    );
  }
}
