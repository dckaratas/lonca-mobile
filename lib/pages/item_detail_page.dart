import 'package:flutter/material.dart';

import '../data/bag.dart';
import '../models/item.dart';
import '../theme.dart';
import '../widgets/bag_button.dart';
import '../widgets/item_image.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.type), actions: const [BagButton()]),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: item.rarityColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: item.rarityColor, width: 2),
            ),
            child: Center(child: ItemImage(item: item, size: 120)),
          ),
          const SizedBox(height: 20),
          Text(item.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(item.rarity, style: TextStyle(color: item.rarityColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Text(item.description, style: const TextStyle(fontSize: 16, height: 1.4)),
          const SizedBox(height: 20),
          _StatBar(label: 'Saldırı', value: item.attack, color: const Color(0xFFC0583A)),
          _StatBar(label: 'Savunma', value: item.defense, color: const Color(0xFF7FAED0)),
          _StatBar(label: 'Büyü', value: item.magic, color: const Color(0xFFB08AD6)),
          const SizedBox(height: 12),
          Text('Stokta ${item.stock} adet', style: const TextStyle(color: LoncaColors.ash, fontStyle: FontStyle.italic)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListenableBuilder(
            listenable: bag,
            builder: (context, _) {
              final inBag = bag.quantityOf(item);
              final soldOut = inBag >= item.stock;
              return FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                onPressed: soldOut
                    ? null
                    : () {
                        bag.add(item);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('${item.name} heybeye eklendi')));
                      },
                icon: const Icon(Icons.backpack),
                label: Text(soldOut
                    ? 'Stok tükendi'
                    : 'Heybeye Ekle — 🪙 ${item.price}${inBag > 0 ? '  (heybede $inBag)' : ''}'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBar({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 72, child: Text(label)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value / 50,
                minHeight: 10,
                color: color,
                backgroundColor: color.withValues(alpha: 0.15),
              ),
            ),
          ),
          SizedBox(width: 36, child: Text('$value', textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
