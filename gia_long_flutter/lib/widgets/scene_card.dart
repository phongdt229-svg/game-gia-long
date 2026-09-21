import 'package:flutter/material.dart';

import '../models/scene.dart';

/// Thẻ hiển thị nội dung một cảnh: tiêu đề, địa điểm, lời kể, sử liệu.
class SceneCard extends StatelessWidget {
  const SceneCard({super.key, required this.scene});

  final Scene scene;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scene.title,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (scene.location != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.place_outlined, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      scene.location!,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 14),
            Text(scene.text, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6)),
            if (scene.historyNote != null) ...[
              const SizedBox(height: 14),
              Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(bottom: 8),
                  leading: const Icon(Icons.menu_book_outlined, size: 20),
                  title: Text('Sử liệu thật', style: theme.textTheme.titleSmall),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        scene.historyNote!,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
