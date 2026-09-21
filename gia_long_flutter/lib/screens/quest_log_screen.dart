import 'package:flutter/material.dart';

import '../models/player_state.dart';
import '../models/quest.dart';
import '../story/story_registry.dart';

/// Nhật ký nhiệm vụ: tab "Đang làm" và "Hoàn thành".
class QuestLogScreen extends StatelessWidget {
  const QuestLogScreen({super.key, required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final active = _quests(state.activeQuests);
    final done = _quests(state.completedQuests);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nhật ký nhiệm vụ'),
          bottom: TabBar(tabs: [
            Tab(text: 'Đang làm (${active.length})'),
            Tab(text: 'Hoàn thành (${done.length})'),
          ]),
        ),
        body: TabBarView(children: [
          _QuestList(quests: active, emptyText: 'Chưa có nhiệm vụ nào đang thực hiện.'),
          _QuestList(quests: done, emptyText: 'Chưa hoàn thành nhiệm vụ nào.', completed: true),
        ]),
      ),
    );
  }

  static List<Quest> _quests(Set<String> ids) => [
        for (final q in allQuests)
          if (ids.contains(q.id)) q,
      ];
}

class _QuestList extends StatelessWidget {
  const _QuestList({required this.quests, required this.emptyText, this.completed = false});

  final List<Quest> quests;
  final String emptyText;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    if (quests.isEmpty) return Center(child: Text(emptyText));
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (final q in quests)
          Card(
            child: ListTile(
              leading: Icon(
                completed ? Icons.check_circle : Icons.flag_outlined,
                color: completed ? theme.colorScheme.primary : null,
              ),
              title: Text(q.title),
              subtitle: Text(
                'Hồi ${q.act} · ${q.type.label}\n${q.description}'
                '${completed ? '\nPhần thưởng: ${q.reward}' : ''}',
              ),
              isThreeLine: true,
            ),
          ),
      ],
    );
  }
}
