import 'package:flutter/material.dart';

/// Demirci dükkanındaki bir eşya.
class Item {
  final int id;
  final String name;
  final String type;
  final String rarity;
  final int price;
  final int stock;
  final int attack;
  final int defense;
  final int magic;
  final String emoji;
  final String image;
  final String description;

  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.rarity,
    required this.price,
    required this.stock,
    required this.attack,
    required this.defense,
    required this.magic,
    required this.emoji,
    required this.image,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      rarity: json['rarity'] as String,
      price: json['price'] as int,
      stock: json['stock'] as int? ?? 0,
      attack: json['attack'] as int? ?? 0,
      defense: json['defense'] as int? ?? 0,
      magic: json['magic'] as int? ?? 0,
      emoji: json['emoji'] as String? ?? '❔',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'rarity': rarity,
        'price': price,
        'stock': stock,
        'attack': attack,
        'defense': defense,
        'magic': magic,
        'emoji': emoji,
        'image': image,
        'description': description,
      };

  /// Nadirlik seviyesine göre kart rengi.
  Color get rarityColor {
    switch (rarity) {
      case 'Efsanevi':
        return const Color(0xFFE0A84A);
      case 'Epik':
        return const Color(0xFFB08AD6);
      case 'Nadir':
        return const Color(0xFF7FAED0);
      default:
        return const Color(0xFFA8987A);
    }
  }
}
