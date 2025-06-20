import 'package:flutter/material.dart';

class BurgerPage extends StatefulWidget {
    static const tag = '/burger'; 

    @override
   _BurgerPageState createState() => _BurgerPageState();
}

class _BurgerPageState extends State<BurgerPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar : AppBar(
                title: Text('Burger page'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.asset('images/bacon-burger.', width: 150),
                        SizedBox(height: 20),
                        Text(
                            'Bacon burger',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                    ],
                ),
            ),
        );
    }
}