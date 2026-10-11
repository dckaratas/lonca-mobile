import 'package:flutter/material.dart';

import '../models/item.dart';
import '../theme.dart';
import 'item_image.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: LoncaColors.box(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          splashColor: LoncaColors.gold.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Center(child: ItemImage(item: item))),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.15),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      item.rarity,
                      style: TextStyle(color: item.rarityColor, fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    const Spacer(),
                    Text('🪙 ${item.price}', style: const TextStyle(color: LoncaColors.gold, fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
