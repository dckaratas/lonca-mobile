import 'package:flutter/material.dart';

import '../models/item.dart';

/// Eşya görseli. Asset bulunamazsa eşyanın emojisi gösterilir.
class ItemImage extends StatelessWidget {
  final Item item;
  final double size;

  const ItemImage({super.key, required this.item, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      item.image,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Text(item.emoji, style: TextStyle(fontSize: size * 0.75)),
    );
  }
}
