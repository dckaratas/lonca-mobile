import 'package:flutter/foundation.dart';

import '../models/item.dart';

/// Heybe (sepet) — basit state yönetimi simülasyonu.
/// Ekstra paket kullanmamak için Flutter'ın kendi ChangeNotifier'ı kullanılır.
class Bag extends ChangeNotifier {
  final Map<int, ({Item item, int quantity})> _lines = {};

  List<Item> get items => [for (final line in _lines.values) line.item];
  int quantityOf(Item item) => _lines[item.id]?.quantity ?? 0;
  int get count => _lines.values.fold(0, (sum, line) => sum + line.quantity);
  int get totalGold => _lines.values.fold(0, (sum, line) => sum + line.item.price * line.quantity);

  void add(Item item) {
    final quantity = quantityOf(item);
    if (quantity >= item.stock) return; // stoktan fazla eklenemez
    _lines[item.id] = (item: item, quantity: quantity + 1);
    notifyListeners();
  }

  void removeOne(Item item) {
    final quantity = quantityOf(item);
    if (quantity <= 1) {
      _lines.remove(item.id);
    } else {
      _lines[item.id] = (item: item, quantity: quantity - 1);
    }
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}

/// Uygulama genelinde tek heybe.
final bag = Bag();
