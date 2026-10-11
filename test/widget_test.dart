import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lonca_mobile/data/bag.dart';
import 'package:lonca_mobile/main.dart';
import 'package:lonca_mobile/models/item.dart';

const _sword = Item(
  id: 1,
  name: 'Test Kılıcı',
  type: 'Silah',
  rarity: 'Nadir',
  price: 100,
  stock: 2,
  attack: 10,
  defense: 0,
  magic: 0,
  emoji: '🗡️',
  image: '',
  description: '',
);

void main() {
  test('Item.fromJson / toJson', () {
    final item = Item.fromJson(_sword.toJson());
    expect(item.name, 'Test Kılıcı');
    expect(item.price, 100);
  });

  test('Heybe stok sınırını aşmaz ve toplamı hesaplar', () {
    final bag = Bag();
    bag.add(_sword);
    bag.add(_sword);
    bag.add(_sword); // stok 2, eklenmemeli
    expect(bag.count, 2);
    expect(bag.totalGold, 200);

    bag.removeOne(_sword);
    expect(bag.count, 1);
  });

  testWidgets('Ana sayfa eşyaları listeler, detaya gidip heybeye ekler', (tester) async {
    await tester.pumpWidget(const LoncaApp());
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pumpAndSettle();

    expect(find.text('Demirci Dükkanı'), findsOneWidget);
    expect(find.text('Ejderha Dişi Kılıcı'), findsOneWidget);

    await tester.ensureVisible(find.text('Ejderha Dişi Kılıcı'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ejderha Dişi Kılıcı'));
    await tester.pumpAndSettle();
    expect(find.text('Kül Dağı ejderhasının dişinden dövülmüş. Kabzası hâlâ sıcak.'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(bag.count, 1);
  });
}
