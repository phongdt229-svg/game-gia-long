import 'package:flutter/material.dart';

import '../services/save_service.dart';

/// Cài đặt: cỡ chữ và xóa dữ liệu đã lưu.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.save, required this.textScale});

  final SaveService save;
  final ValueNotifier<double> textScale;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _clearSave() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa dữ liệu lưu?'),
        content: const Text('Toàn bộ tiến trình đã lưu sẽ bị xóa và không thể khôi phục.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xóa')),
        ],
      ),
    );
    if (ok != true) return;
    await widget.save.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa dữ liệu lưu.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ValueListenableBuilder<double>(
            valueListenable: widget.textScale,
            builder: (context, scale, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cỡ chữ: ${(scale * 100).round()}%', style: Theme.of(context).textTheme.titleMedium),
                Slider(
                  value: scale,
                  min: 0.85,
                  max: 1.4,
                  divisions: 11,
                  onChanged: (v) => widget.textScale.value = v,
                  onChangeEnd: widget.save.saveTextScale,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _clearSave,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Xóa dữ liệu lưu'),
          ),
        ],
      ),
    );
  }
}
