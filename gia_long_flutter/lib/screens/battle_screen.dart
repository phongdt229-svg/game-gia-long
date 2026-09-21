import 'package:flutter/material.dart';

import '../game/battle_engine.dart';
import '../models/battle.dart';
import '../models/player_state.dart';

/// Màn chiến đấu theo lượt. Trả về [BattleResult] khi người chơi bấm "Tiếp tục".
class BattleScreen extends StatefulWidget {
  const BattleScreen({
    super.key,
    required this.def,
    required this.state,
    required this.weakened,
  });

  final BattleDef def;
  final PlayerState state;
  final bool weakened;

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late final BattleEngine engine = BattleEngine(
    def: widget.def,
    army: widget.state.stat('army'),
    food: widget.state.stat('food'),
    morale: widget.state.stat('morale'),
    weakened: widget.weakened,
  );

  void _act(PlayerAction action) => setState(() => engine.act(action));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phase = engine.phase;
    final recentLog = engine.log.reversed.take(6).toList();
    return Scaffold(
      appBar: AppBar(title: Text(widget.def.title)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _HpCard(
                  title: '${widget.def.enemyName} — ${phase.name}',
                  subtitle: widget.weakened ? 'Địch đã suy yếu nhờ chuẩn bị của bạn' : null,
                  hp: engine.enemyHp,
                  maxHp: engine.enemyMaxHp,
                  color: theme.colorScheme.error,
                  trailing: widget.def.phases.length > 1
                      ? 'Giai đoạn ${engine.phaseIndex + 1}/${widget.def.phases.length}'
                      : null,
                ),
                const SizedBox(height: 10),
                if (!engine.finished)
                  Card(
                    color: theme.colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(Icons.visibility_outlined),
                          const SizedBox(width: 10),
                          Expanded(child: Text('Địch chuẩn bị: ${engine.nextMove.label}')),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                _HpCard(
                  title: 'Quân ta',
                  hp: engine.playerHp,
                  maxHp: engine.playerMaxHp,
                  color: theme.colorScheme.primary,
                  trailing: 'Tinh thần: ${engine.morale}',
                ),
                const SizedBox(height: 14),
                if (engine.finished) ..._buildFinished(theme) else ..._buildActions(),
                const SizedBox(height: 14),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < recentLog.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              recentLog[i],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: i == 0 ? null : theme.hintColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      FilledButton.icon(
        onPressed: () => _act(PlayerAction.attack),
        icon: const Icon(Icons.gavel),
        label: const Text('Tấn công'),
      ),
      const SizedBox(height: 8),
      FilledButton.tonalIcon(
        onPressed: () => _act(PlayerAction.defend),
        icon: const Icon(Icons.shield_outlined),
        label: const Text('Phòng thủ (giảm 60% sát thương)'),
      ),
      const SizedBox(height: 8),
      FilledButton.tonalIcon(
        onPressed: engine.canUseSkill ? () => _act(PlayerAction.skill) : null,
        icon: const Icon(Icons.auto_awesome),
        label: const Text(
          'Dùng kế sách (-${BattleEngine.skillCost} tinh thần, sát thương x2, xuyên phòng thủ)',
        ),
      ),
    ];
  }

  List<Widget> _buildFinished(ThemeData theme) {
    final won = engine.won!;
    return [
      Card(
        color: won ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            won ? widget.def.winText : widget.def.loseText,
            style: theme.textTheme.titleMedium,
          ),
        ),
      ),
      const SizedBox(height: 10),
      FilledButton(
        onPressed: () => Navigator.of(context).pop(engine.result),
        child: const Text('Tiếp tục'),
      ),
    ];
  }
}

class _HpCard extends StatelessWidget {
  const _HpCard({
    required this.title,
    required this.hp,
    required this.maxHp,
    required this.color,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final String? trailing;
  final int hp;
  final int maxHp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: theme.textTheme.titleSmall)),
                if (trailing != null) Text(trailing!, style: theme.textTheme.bodySmall),
              ],
            ),
            if (subtitle != null)
              Text(subtitle!, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: maxHp == 0 ? 0 : hp / maxHp,
                minHeight: 10,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text('$hp / $maxHp', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
