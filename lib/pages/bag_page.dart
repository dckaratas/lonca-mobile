import 'package:flutter/material.dart';

import '../data/bag.dart';
import '../widgets/item_image.dart';

/// Heybe (sepet) sayfası — satın alma simülasyonu.
class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heybem')),
      body: ListenableBuilder(
        listenable: bag,
        builder: (context, _) {
          final items = bag.items;
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Heyben bomboş. Dükkâna bir göz at!'),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Dükkâna Dön'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: SizedBox(width: 48, child: ItemImage(item: item, size: 40)),
                      title: Text(item.name),
                      subtitle: Text('🪙 ${item.price} × ${bag.quantityOf(item)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => bag.removeOne(item),
                          ),
                          Text('${bag.quantityOf(item)}'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => bag.add(item),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text('Toplam: 🪙 ${bag.totalGold}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      FilledButton(
                        onPressed: () {
                          bag.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Satın alındı! İyi maceralar ⚔️')),
                          );
                        },
                        child: const Text('Satın Al'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
