import 'package:flutter/material.dart';

import '../models/base_building.dart';
import '../models/player_state.dart';
import '../widgets/stat_chip.dart';

/// Màn xây dựng căn cứ: mỗi mùa vụ chọn một việc lớn.
/// Trả về chỉ số cuối cùng (`Map<String, int>`) khi hoàn tất.
class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.def, required this.state});

  final BaseDef def;
  final PlayerState state;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  /// Bản sao làm việc: thoát giữa chừng thì ván chơi thật không bị đổi.
  late final PlayerState work = PlayerState.fromJson(widget.state.toJson());
  late int turnsLeft = widget.def.turns;

  bool _isLocked(BaseAction a) => a.requiresFlag != null && !work.flags.contains(a.requiresFlag);

  void _perform(BaseAction action) {
    setState(() {
      work.applyEffect(action.effect);
      turnsLeft--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final done = turnsLeft == 0;
    return Scaffold(
      appBar: AppBar(title: Text(widget.def.title)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StatBar(stats: work.stats),
                const SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mục tiêu', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 6),
                        for (final goal in widget.def.goals)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(
                                  work.meets(goal.requires)
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  size: 18,
                                  color: work.meets(goal.requires) ? theme.colorScheme.primary : null,
                                ),
                                const SizedBox(width: 8),
                                Expanded(child: Text(goal.description)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  done
                      ? 'Các mùa vụ đã kết thúc.'
                      : 'Mùa vụ ${widget.def.turns - turnsLeft + 1}/${widget.def.turns} — chọn một việc lớn:',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (done)
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(Map<String, int>.of(work.stats)),
                    child: const Text('Hoàn tất'),
                  )
                else
                  for (final action in widget.def.actions) _actionTile(theme, action),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionTile(ThemeData theme, BaseAction action) {
    final locked = _isLocked(action);
    return Card(
      child: ListTile(
        enabled: !locked,
        leading: Icon(locked ? Icons.lock_outline : Icons.construction),
        title: Text(action.name),
        subtitle: Text(
          locked
              ? (action.lockedHint ?? 'Chưa đủ điều kiện')
              : '${action.description}\n${PlayerState.describeEffect(action.effect)}',
        ),
        isThreeLine: !locked,
        onTap: locked ? null : () => _perform(action),
      ),
    );
  }
}
