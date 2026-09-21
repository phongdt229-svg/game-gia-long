import 'package:flutter/material.dart';

import '../game/game_controller.dart';
import '../services/save_service.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

/// Màn hình chính: Chơi mới / Tiếp tục / Cài đặt.
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key, required this.save, required this.textScale});

  final SaveService save;
  final ValueNotifier<double> textScale;

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool _hasSave = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final has = await widget.save.hasSave();
    if (mounted) setState(() => _hasSave = has);
  }

  Future<void> _open(GameController controller) async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => GameScreen(controller: controller),
    ));
    _refresh();
  }

  Future<void> _newGame() async {
    if (_hasSave) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Bắt đầu ván mới?'),
          content: const Text('Tiến trình đã lưu sẽ bị ghi đè.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Chơi mới')),
          ],
        ),
      );
      if (ok != true) return;
    }
    if (!mounted) return;
    await _open(GameController.newGame(widget.save));
  }

  Future<void> _continue() async {
    final saved = await widget.save.load();
    if (!mounted) return;
    if (saved == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không đọc được bản lưu. Hãy bắt đầu ván mới.')),
      );
      _refresh();
      return;
    }
    await _open(GameController.resume(widget.save, saved));
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => SettingsScreen(save: widget.save, textScale: widget.textScale),
    ));
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'GIA LONG',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Hành Trình Thống Nhất',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '1777 — 1802',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                  ),
                  const SizedBox(height: 40),
                  FilledButton(onPressed: _newGame, child: const Text('Chơi mới')),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: _hasSave ? _continue : null,
                    child: const Text('Tiếp tục'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _openSettings, child: const Text('Cài đặt')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
