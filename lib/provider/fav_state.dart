import 'package:fav_app/model/items.dart';
import 'package:flutter/material.dart';

class FavState {
  final List<Items> allItems;
  final List<Items> favfiltered;
  final String search;


  FavState({
    required this.allItems,
    required this.favfiltered,
    required this.search,
  });


 FavState copyWith({
    required List<Items>? allItems,
    required List<Items>? favfiltered,
    required String? search,
  }) {
    return FavState(
      allItems: allItems ?? this.allItems,
      favfiltered: favfiltered ?? this.favfiltered,
      search: search ?? this.search,
    );
  }




}