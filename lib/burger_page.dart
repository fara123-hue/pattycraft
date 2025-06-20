// burger_page.dart
import 'package:flutter/material.dart';

class BurgerPage extends StatefulWidget {
  static const tag = '/burger';
  final Map<String, dynamic>? burgerData;

  BurgerPage({this.burgerData});

  @override
  _BurgerPageState createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.burgerData ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(data['strMeal'] ?? 'Burger page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            data['strMealThumb'] != null
                ? Image.network(
                    data['strMealThumb'],
                    width: 150,
                  )
                : Image.asset('images/bacon-burger.png', width: 150),
            SizedBox(height: 20),
            Text(
              data['strMeal'] ?? 'Bacon Burger',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                data['strInstructions'] ?? 'No description available.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
