import 'package:flutter/material.dart';

import '../models/player_state.dart';
import '../models/quest.dart';
import '../story/story_registry.dart';
import '../widgets/stat_chip.dart';

/// Màn tổng kết hành trình sau Hồi 6.
class EndingScreen extends StatelessWidget {
  const EndingScreen({super.key, required this.state});

  final PlayerState state;

  String get _verdict {
    if (state.flags.contains('khoan_dung')) {
      return 'Ngài được nhớ đến như vị vua biết khép lại hận thù để dựng nên một quốc gia mới.';
    }
    if (state.flags.contains('bao_thu')) {
      return 'Ngài thống nhất non sông, nhưng bóng đen của cuộc trả thù còn đè nặng lên triều đại mới.';
    }
    return 'Ngài thống nhất non sông sau hai mươi lăm năm bền bỉ.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleQuests = allQuests.where((q) => q.type != QuestType.hidden).length;
    final doneQuests =
        state.completedQuests.where((id) => questsById[id]?.type != QuestType.hidden).length;
    final foundHidden = state.completedQuests.contains('Q3_DaChieu');
    return Scaffold(
      appBar: AppBar(title: const Text('Tổng kết hành trình')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Gia Long — Hành Trình Thống Nhất',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(_verdict, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
                const SizedBox(height: 16),
                StatBar(stats: state.stats),
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(Icons.task_alt),
                    title: Text('Nhiệm vụ hoàn thành: $doneQuests/$visibleQuests'),
                    subtitle: Text(foundHidden
                        ? 'Đã mở khóa nhiệm vụ ẩn "Góc Nhìn Đa Chiều".'
                        : 'Còn một nhiệm vụ ẩn chưa được khám phá.'),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Những lựa chọn định đoạt hành trình', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                if (state.choiceLog.isEmpty)
                  const Text('Bạn chưa đưa ra lựa chọn quan trọng nào.')
                else
                  for (final entry in state.choiceLog)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.bookmark_outline, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(entry)),
                        ],
                      ),
                    ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                  child: const Text('Về màn hình chính'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
