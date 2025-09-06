import 'package:fav_app/provider/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favList = ref.watch(favProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App') ,
       
      actions: [
        PopupMenuButton(
         
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'all',
              child: Text('All Items'),
            ),
            const PopupMenuItem(
              value: 'favorites',
              child: Text('Favorites'),
            ),
          ],
          onSelected: (value) {
            if (value == 'all') {
              ref.read(favProvider.notifier).filterList('');
            } else if (value == 'favorites') {
              ref.read(favProvider.notifier).filterList('true');
            }
          },
        ),
      ],
      
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
               ref.read(favProvider.notifier).filterList(value);
            },
          ),


          Expanded(
            child: ListView.builder(
              itemCount: favList.favfiltered.length,
              itemBuilder: (context, index) {
                final item = favList.favfiltered[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Icon(
                    item.fav ? Icons.favorite : Icons.favorite_border,
                    color: item.fav ? Colors.red : null,
                  ),
                  onTap: () {
                     ref.read(favProvider.notifier).toggleFav(item.id);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(favProvider.notifier).addItems(favList.allItems);
        },
        child: const Icon(Icons.add),
    ));
  }
}
