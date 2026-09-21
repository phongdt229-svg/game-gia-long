import 'package:flutter/material.dart';

import '../models/scene.dart';
import '../services/asset_catalog.dart';
import '../story/asset_map.dart';

/// Nền của một cảnh: gradient theo Hồi, phủ hình nền nếu có, kèm lớp tối cho dễ đọc chữ.
class SceneBackdrop extends StatelessWidget {
  const SceneBackdrop({super.key, required this.scene, required this.child});

  final Scene scene;
  final Widget child;

  static const _palettes = <int, List<Color>>{
    1: [Color(0xFF0B1026), Color(0xFF1E2A4A)], // đêm Gia Định
    2: [Color(0xFF0B2A2A), Color(0xFF1F4B4B)], // biển, Xiêm La
    3: [Color(0xFF2A0F1A), Color(0xFF4A2030)], // triều đình, ngoại giao
    4: [Color(0xFF14260F), Color(0xFF35502A)], // căn cứ, đồn điền
    5: [Color(0xFF2B140C), Color(0xFF5A2E1A)], // chiến trận
    6: [Color(0xFF2A210A), Color(0xFF6B5310)], // hoàng cung
  };

  @override
  Widget build(BuildContext context) {
    final colors = _palettes[scene.act] ?? _palettes[1]!;
    final bg = backgroundFor(scene);
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        ),
        if (AssetCatalog.has(bg))
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Image.asset(
              bg!,
              key: ValueKey(bg),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        const ColoredBox(color: Color(0x99000000)),
        child,
      ],
    );
  }
}
