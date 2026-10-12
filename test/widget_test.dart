import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

// Uygulamayı açar ve eşyalar asset dosyasından yüklenip ızgara görünene kadar bekler
Future<void> _openShop(WidgetTester tester) async {
  await tester.pumpWidget(const LoncaApp());
  for (var i = 0; i < 40 && find.byType(GridView).evaluate().isEmpty; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

void main() {
  // rootBundle önbelleği önceki testin sanal zamanında kalmasın
  setUp(() => rootBundle.clear());

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
    await _openShop(tester);

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

  testWidgets('Eşyalar GridView ile listelenir, boş heybeden dükkâna dönülür', (tester) async {
    bag.clear();
    await _openShop(tester);
    expect(find.byType(GridView), findsOneWidget);

    await tester.tap(find.byIcon(Icons.backpack_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Heyben bomboş. Dükkâna bir göz at!'), findsOneWidget);

    await tester.tap(find.text('Dükkâna Dön'));
    await tester.pumpAndSettle();
    expect(find.byType(GridView), findsOneWidget);
  });
}
