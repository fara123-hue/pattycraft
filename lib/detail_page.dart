import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/favorite_model.dart';
import 'models/notification_model.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> meal;

  const DetailPage({required this.meal});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _cheeseExtra = false;
  bool _spicySauce = false;
  int _quantity = 1;
  String _note = "";

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal['strMeal'] ?? 'Detail'),
  backgroundColor: Colors.teal,
  actions: [
    Consumer<FavoriteModel>(
      builder: (context, fav, _) {
        final isFav = fav.isFavorite(meal['strMeal']);
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          color: isFav ? Colors.red : Colors.white,
          onPressed: () {
            fav.toggleFavorite(meal);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(isFav ? 'Dihapus dari Favorit' : 'Ditambahkan ke Favorit')),
            );
          },
        );
      },
    ),
  ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal['strMealThumb'] ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal['strMeal'] ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.grey[700], size: 20),
                      SizedBox(width: 5),
                      Text("20-30 menit", style: TextStyle(color: Colors.grey[700])),
                      SizedBox(width: 15),
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 5),
                      Text("4.8 (2.3rb+)", style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Deskripsi
                  Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(meal['strInstructions'] ?? 'Tidak ada deskripsi.'),
                  SizedBox(height: 20),

                  // Topping
                  Text("Tambahan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  CheckboxListTile(
                    title: Text("Keju ekstra"),
                    value: _cheeseExtra,
                    onChanged: (val) => setState(() => _cheeseExtra = val!),
                  ),
                  CheckboxListTile(
                    title: Text("Saus pedas"),
                    value: _spicySauce,
                    onChanged: (val) => setState(() => _spicySauce = val!),
                  ),

                  // Catatan
                  SizedBox(height: 10),
                  Text("Catatan untuk penjual"),
                  SizedBox(height: 5),
                  TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Contoh: tanpa bawang, pedas sedikit",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) => _note = val,
                  ),

                  // Jumlah
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Jumlah:", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (_quantity > 1) setState(() => _quantity--);
                        },
                      ),
                      Text(_quantity.toString(), style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),

                  // Tombol tambah ke keranjang
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Tambahkan ke Keranjang", style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        final cart = Provider.of<CartModel>(context, listen: false);
                        cart.addItem({
                          'strMeal': meal['strMeal'],
                          'strMealThumb': meal['strMealThumb'],
                          'note': _note,
                          'cheeseExtra': _cheeseExtra,
                          'spicySauce': _spicySauce,
                          'quantity': _quantity,
                        });

                        Provider.of<NotificationModel>(context, listen: false)
                          .addMessage("${meal['strMeal']} ditambahkan ke keranjang");


                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${meal['strMeal']} ditambahkan ke keranjang."),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
