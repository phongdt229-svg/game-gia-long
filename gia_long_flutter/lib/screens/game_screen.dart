import 'package:flutter/material.dart';

import '../game/game_controller.dart';
import '../models/battle.dart';
import '../models/scene.dart';
import '../services/audio_service.dart';
import '../story/asset_map.dart';
import '../story/story_registry.dart';
import '../widgets/choice_button.dart';
import '../widgets/scene_backdrop.dart';
import '../widgets/scene_card.dart';
import '../widgets/stat_chip.dart';
import 'base_screen.dart';
import 'battle_screen.dart';
import 'ending_screen.dart';
import 'quest_log_screen.dart';

/// Màn chơi chính: hiển thị cảnh hiện tại, chỉ số và các lựa chọn.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.controller});

  final GameController controller;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _scroll = ScrollController();

  GameController get c => widget.controller;

  @override
  void initState() {
    super.initState();
    c.addListener(_onChanged);
    _onChanged(); // hiện thông báo đang chờ (ví dụ khi Tiếp tục ván cũ)
    _syncMusic();
  }

  @override
  void dispose() {
    c.removeListener(_onChanged);
    AudioService.instance.stop();
    _scroll.dispose();
    super.dispose();
  }

  void _syncMusic() => AudioService.instance.playMusic(musicFor(c.scene));

  void _onChanged() {
    _syncMusic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_scroll.hasClients) _scroll.jumpTo(0);
      _showNotices();
    });
  }

  void _showNotices() {
    final notices = c.takeNotices();
    if (notices.isEmpty) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(notices.join('\n')),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
  }

  Future<void> _openBattle(Scene scene) async {
    final def = battlesById[scene.battleId]!;
    final result =
        await Navigator.of(context).push<BattleResult>(MaterialPageRoute(
      builder: (_) =>
          BattleScreen(def: def, state: c.state, weakened: c.isWeakened(def)),
    ));
    if (result != null) c.finishBattle(def, result);
  }

  Future<void> _openBase(Scene scene) async {
    final def = basesById[scene.baseId]!;
    final stats =
        await Navigator.of(context).push<Map<String, int>>(MaterialPageRoute(
      builder: (_) => BaseScreen(def: def, state: c.state),
    ));
    if (stats != null) c.finishBase(def, stats);
  }

  void _openQuestLog() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => QuestLogScreen(state: c.state),
    ));
  }

  Future<void> _restartAct() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Chơi lại Hồi này?'),
        content: const Text('Tiến trình từ đầu Hồi hiện tại sẽ bị xóa.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Chơi lại')),
        ],
      ),
    );
    if (ok == true) c.restoreCheckpoint();
  }

  void _openEnding() {
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      builder: (_) => EndingScreen(state: c.state),
    ));
  }

  void _onMenuSelected(String value) {
    switch (value) {
      case 'quests':
        _openQuestLog();
      case 'restart':
        _restartAct();
      case 'menu':
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: c,
      builder: (context, _) {
        final scene = c.scene;
        return Scaffold(
          appBar: AppBar(
            title: Text(actTitles[scene.act] ?? 'Hồi ${scene.act}',
                style: const TextStyle(fontSize: 16)),
            actions: [
              PopupMenuButton<String>(
                onSelected: _onMenuSelected,
                itemBuilder: (_) => const [
                  PopupMenuItem(
                      value: 'quests', child: Text('Nhật ký nhiệm vụ')),
                  PopupMenuItem(
                      value: 'restart', child: Text('Chơi lại Hồi này')),
                  PopupMenuItem(
                      value: 'menu', child: Text('Về màn hình chính')),
                ],
              ),
            ],
          ),
          body: SceneBackdrop(
            scene: scene,
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: StatBar(stats: c.state.stats),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scroll,
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Column(
                              key: ValueKey(scene.id),
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SceneCard(scene: scene),
                                const SizedBox(height: 16),
                                ..._buildActions(scene),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(Scene scene) {
    switch (scene.type) {
      case SceneType.battle:
        return [
          FilledButton.icon(
            onPressed: () => _openBattle(scene),
            icon: const Icon(Icons.security),
            label: const Text('Ra trận'),
          ),
        ];
      case SceneType.base:
        return [
          FilledButton.icon(
            onPressed: () => _openBase(scene),
            icon: const Icon(Icons.home_work_outlined),
            label: const Text('Bắt tay xây dựng'),
          ),
        ];
      case SceneType.ending:
        return [
          FilledButton.icon(
            onPressed: _openEnding,
            icon: const Icon(Icons.flag),
            label: const Text('Xem tổng kết hành trình'),
          ),
        ];
      case SceneType.story:
        return [
          for (final choice in c.visibleChoices)
            ChoiceButton(
              text: choice.text,
              lockedReason: c.lockedReason(choice),
              onPressed: () {
                if (choice.next == menuToken) {
                  Navigator.of(context).pop();
                } else {
                  c.choose(choice);
                }
              },
            ),
        ];
    }
  }
}
