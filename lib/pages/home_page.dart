import 'package:flutter/material.dart';

import '../data/item_repository.dart';
import '../models/item.dart';
import '../routes.dart';
import '../theme.dart';
import '../widgets/bag_button.dart';
import '../widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Item>> _itemsFuture = ItemRepository().fetchItems();

  String _query = '';
  String? _selectedType; // null = tümü

  List<Item> _filter(List<Item> items) {
    return items.where((item) {
      final matchesType = _selectedType == null || item.type == _selectedType;
      final matchesQuery = item.name.toLowerCase().contains(_query.toLowerCase());
      return matchesType && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demirci Dükkanı'),
        actions: const [BagButton()],
      ),
      body: FutureBuilder<List<Item>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Eşyalar yüklenemedi: ${snapshot.error}'));
          }

          final items = snapshot.data!;
          final types = items.map((e) => e.type).toSet().toList();
          final visible = _filter(items);

          // Banner, arama ve filtreler kaydırınca ızgarayla birlikte yukarı kayar
          return NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const _Banner(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Eşya ara…',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) => setState(() => _query = value),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          _typeChip('Tümü', null),
                          for (final type in types) _typeChip(type, type),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: visible.isEmpty
                ? const Center(child: Text('Aradığın eşya bu dükkânda yok.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: visible.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      return ItemCard(
                        item: item,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.detail, arguments: item),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _typeChip(String label, String? type) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedType == type,
        onSelected: (_) => setState(() => _selectedType = type),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      // Parşömen blok
      decoration: BoxDecoration(
        color: LoncaColors.parchment,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: LoncaColors.goldDark),
        boxShadow: const [BoxShadow(color: Color(0xAA000000), blurRadius: 30, offset: Offset(0, 10))],
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HOŞ GELDİN, MACERACI',
                    style: TextStyle(
                        color: LoncaColors.bronze, fontSize: 16, letterSpacing: 1.8, fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Text('Bir sonraki görevin için donanımını seç.',
                    style: TextStyle(color: LoncaColors.ink, fontSize: 17, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          Text('⚒️', style: TextStyle(fontSize: 44)),
        ],
      ),
    );
  }
}
