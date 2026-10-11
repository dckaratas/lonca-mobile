import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/item.dart';

/// Eşya verilerini asset içindeki JSON dosyasından okur (API simülasyonu).
class ItemRepository {
  static const _path = 'assets/data/items.json';

  Future<List<Item>> fetchItems() async {
    final raw = await rootBundle.loadString(_path);
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Item.fromJson(e as Map<String, dynamic>)).toList();
  }
}
