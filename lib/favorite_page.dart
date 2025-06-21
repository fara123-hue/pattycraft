import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorite_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteModel>(context).items;

    return Scaffold(
      appBar: AppBar(title: Text("Favorit")),
      body: favorites.isEmpty
          ? Center(child: Text("Belum ada makanan favorit."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];
                return ListTile(
                  leading: Image.network(item['strMealThumb'], width: 50),
                  title: Text(item['strMeal']),
                  trailing: Icon(Icons.favorite, color: Colors.red),
                );
              },
            ),
    );
  }
}
