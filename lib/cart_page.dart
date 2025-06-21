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
        backgroundColor: Colors.teal,
      ),
      body: cart.items.isEmpty
          ? Center(child: Text('Keranjang masih kosong 😢'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item['strMealThumb'] ?? '',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item['strMeal'] ?? 'Tanpa nama',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jumlah: ${item['quantity'] ?? 1}"),
                              if (item['cheeseExtra'] == true)
                                Text("🧀 Keju ekstra"),
                              if (item['spicySauce'] == true)
                                Text("🌶️ Saus pedas"),
                              if ((item['note'] ?? "").toString().isNotEmpty)
                                Text("📝 Catatan: ${item['note']}"),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => cart.removeItem(item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // TOTAL DAN CHECKOUT
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pesanan:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("${cart.totalItems} item", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        icon: Icon(Icons.payment),
                        label: Text("Checkout"),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Pesanan kamu sedang diproses!")),
                          );
                          cart.clearCart(); // kosongkan keranjang
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
