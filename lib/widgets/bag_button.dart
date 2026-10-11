import 'package:flutter/material.dart';

import '../data/bag.dart';
import '../routes.dart';

/// AppBar'daki heybe ikonu; içindeki eşya sayısını rozet olarak gösterir.
class BagButton extends StatelessWidget {
  const BagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: bag,
      builder: (context, _) => IconButton(
        tooltip: 'Heybe',
        onPressed: () => Navigator.pushNamed(context, AppRoutes.bag),
        icon: Badge(
          isLabelVisible: bag.count > 0,
          label: Text('${bag.count}'),
          child: const Icon(Icons.backpack_outlined),
        ),
      ),
    );
  }
}
