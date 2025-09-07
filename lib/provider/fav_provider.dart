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

  void filterList(String searchOrFav) {
    List<Items> filtered = state.allItems;

    // If filtering favorites
    if (searchOrFav == 'true') {
      filtered = filtered.where((item) => item.fav).toList();
    } else if (searchOrFav == 'false') {
      filtered = filtered.where((item) => !item.fav).toList();
    } else if (searchOrFav.isNotEmpty) {
      filtered = filtered
          .where(
            (item) =>
                item.name.toLowerCase().contains(searchOrFav.toLowerCase()),
          )
          .toList();
    }

    state = state.copyWith(
      favfiltered: filtered,
      search: searchOrFav,
      allItems: state.allItems,
    );
  }

  List<Items> _favitem(List<Items> items, String option) {
    if (option.isEmpty) {
      return items;
    }
    if (option == 'true') {
      return items.where((item) => item.fav).toList();
    } else if (option == 'false') {
      return items.where((item) => !item.fav).toList();
    } else {
      return items
          .where(
            (item) => item.name.toLowerCase().contains(option.toLowerCase()),
          )
          .toList();
    }
  }

  void fav(String option) {
    state = state.copyWith(
      favfiltered: _favitem(state.allItems, option),
      search: option,
      allItems: state.allItems,
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
    List<Items> updatedAllItems = state.allItems.map((item) {
      if (item.id == id) {
        return Items(name: item.name, id: item.id, fav: !item.fav);
      }
      return item;
    }).toList();

    List<Items> updatedFavFiltered = state.favfiltered.map((item) {
      if (item.id == id) {
        return Items(name: item.name, id: item.id, fav: !item.fav);
      }
      return item;
    }).toList();

    state = state.copyWith(
      favfiltered: updatedFavFiltered,
      allItems: updatedAllItems,
      search: state.search,
    );
  }
}
