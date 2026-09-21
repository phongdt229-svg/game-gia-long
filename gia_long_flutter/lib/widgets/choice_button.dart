import 'package:flutter/material.dart';

/// Nút lựa chọn; khi [lockedReason] khác `null` nút bị khóa và hiện lý do.
class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.lockedReason,
  });

  final String text;
  final VoidCallback onPressed;
  final String? lockedReason;

  @override
  Widget build(BuildContext context) {
    final locked = lockedReason != null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        onPressed: locked ? null : onPressed,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        child: Row(
          children: [
            if (locked) ...[
              const Icon(Icons.lock_outline, size: 18),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: const TextStyle(fontSize: 15, height: 1.35)),
                  if (locked)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(lockedReason!, style: Theme.of(context).textTheme.bodySmall),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
