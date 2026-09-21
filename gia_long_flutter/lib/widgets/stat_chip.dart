import 'package:flutter/material.dart';

import '../models/player_state.dart';

/// Hiển thị một chỉ số (Lương thực, Tinh thần, Quân lực, Ngoại giao).
class StatChip extends StatelessWidget {
  const StatChip({super.key, required this.statKey, required this.value});

  final String statKey;
  final int value;

  static const _icons = {
    'food': Icons.rice_bowl,
    'morale': Icons.local_fire_department,
    'army': Icons.shield,
    'diplomacy': Icons.handshake,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = PlayerState.statLabels[statKey] ?? statKey;
    return Tooltip(
      message: '$label: $value/${PlayerState.maxStat}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_icons[statKey] ?? Icons.circle, size: 16, color: scheme.primary),
                const SizedBox(width: 4),
                Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.labelSmall, maxLines: 1),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: value / PlayerState.maxStat,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hàng 4 chỉ số của người chơi.
class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.stats});

  final Map<String, int> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final key in PlayerState.statKeys) ...[
          Expanded(child: StatChip(statKey: key, value: stats[key] ?? 0)),
          if (key != PlayerState.statKeys.last) const SizedBox(width: 6),
        ],
      ],
    );
  }
}
