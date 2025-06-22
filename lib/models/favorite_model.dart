import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  void add(Map<String, dynamic> item) {
    if (!_items.any((e) => e['strMeal'] == item['strMeal'])) {
      _items.add(item);
      notifyListeners();
    }
  }

  void remove(Map<String, dynamic> item) {
    _items.removeWhere((e) => e['strMeal'] == item['strMeal']);
    notifyListeners();
  }

  void toggleFavorite(Map<String, dynamic> item) {
    isFavorite(item['strMeal']) ? remove(item) : add(item);
  }

  bool isFavorite(String mealName) {
    return _items.any((e) => e['strMeal'] == mealName);
  }
}
