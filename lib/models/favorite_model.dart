import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void add(Map<String, dynamic> item) {
    if (!_items.any((element) => element['strMeal'] == item['strMeal'])) {
      _items.add(item);
      notifyListeners();
    }
  }
void toggleFavorite(Map<String, dynamic> item) {
  final exists = _items.any((e) => e['strMeal'] == item['strMeal']);
  if (exists) {
    remove(item);
  } else {
    add(item);
  }
}

  void remove(Map<String, dynamic> item) {
    _items.removeWhere((element) => element['strMeal'] == item['strMeal']);
    notifyListeners();
  }

  bool isFavorite(String mealName) {
    return _items.any((item) => item['strMeal'] == mealName);
  }
}
