import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: cart.items.isEmpty
          ? Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  title: Text(item['strMeal'] ?? 'No name'),
                  leading: Image.network(item['strMealThumb'], width: 50),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => cart.removeItem(item),
                  ),
                );
              },
            ),
    );
  }
}
