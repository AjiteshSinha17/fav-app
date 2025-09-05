import 'package:flutter/material.dart ';

Items items = Items(name: "Item 1", id: 1, fav: false);

final name = items.copyWith(name: 'Item2', id: null, fav: null);

class Items {
  String name;
  int id;
  bool fav;

  Items({required this.name, required this.id, required this.fav});

  Items copyWith({
    required String? name,
    required int? id,
    required bool? fav,
  }) {
    return Items(
      name: name ?? this.name,
      id: id ?? this.id,
      fav: fav ?? this.fav,
    );
  }
}
