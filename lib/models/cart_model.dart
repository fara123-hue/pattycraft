import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems => _items.length;

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      double basePrice = 15.95; // Harga default per item

      // Tambahan harga jika ada topping
      if (item['cheeseExtra'] == true) basePrice += 2.00;
      if (item['spicySauce'] == true) basePrice += 1.50;

      total += basePrice;
    }
    return total;
  }
}
