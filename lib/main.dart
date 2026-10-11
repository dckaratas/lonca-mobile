import 'package:flutter/material.dart';

import 'models/item.dart';
import 'pages/bag_page.dart';
import 'pages/home_page.dart';
import 'pages/item_detail_page.dart';
import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(const LoncaApp());
}

class LoncaApp extends StatelessWidget {
  const LoncaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lonca — Demirci Dükkanı',
      debugShowCheckedModeBanner: false,
      theme: buildLoncaTheme(),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.bag: (_) => const BagPage(),
      },
      // Detay sayfası route argument olarak Item alır
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          final item = settings.arguments as Item;
          return MaterialPageRoute(builder: (_) => ItemDetailPage(item: item));
        }
        return null;
      },
    );
  }
}
