import 'package:fav_app/model/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_app/provider/fav_state.dart';

final favProvider = StateNotifierProvider<FavNotifier, FavState>((ref) {
  return FavNotifier();
});

class FavNotifier extends StateNotifier<FavState> {
  FavNotifier() : super(FavState(allItems: [], favfiltered: [], search: ''));

  void addItems(List<Items> items) {
    List<Items> updatedItems = [
      Items(name: "MacBook Pro", id: 1, fav: false),
      Items(name: "Dell XPS", id: 2, fav: true),
      Items(name: "HP Spectre", id: 3, fav: false),
      Items(name: "Lenovo ThinkPad", id: 4, fav: true),
      Items(name: "Asus ZenBook", id: 5, fav: false),

      Items(name: "Acer Swift", id: 6, fav: true),
      Items(name: "Microsoft Surface", id: 7, fav: false),
      Items(name: "Razer Blade", id: 8, fav: true),
      Items(name: "MSI Prestige", id: 9, fav: false),
    ];

    state = state.copyWith(
      allItems: updatedItems.toList(),
      favfiltered: updatedItems.toList(),
      search: '',
    );
  }

  void filterList(String search) {

  state = state.copyWith(
      favfiltered: _filterItems(state.allItems, search),
      search: search, allItems: [],
    );

  }


  List<Items> _filterItems(List<Items> items, String search) {
    if (search.isEmpty) {
      return items;
    }

    return items
        .where((item) => item.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
   
  void toggleFav(int id) {
    List<Items> updatedItems = state.favfiltered.map((item) {
      if (item.id == id) {
        return Items(name: item.name, id: item.id, fav: !item.fav);
      }
      return item;
    }).toList();

    state = state.copyWith(favfiltered: updatedItems, allItems: [], search: '');
  }
}
