import 'package:flutter/material.dart';

import 'header.dart';
import 'categories.dart';
import 'hamberger_list.dart';
import 'burger_page.dart';
  
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(
        primaryColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.teal, 
          centerTitle: true
          ),
        floatingActionButtonTheme: 
          FloatingActionButtonThemeData(backgroundColor: Colors. orange,
          ),
      ), 
      home: Hamberger(),
      routes: {BurgerPage.tag: (_) => BurgerPage(),
      },
      debugShowCheckedModeBanner: false,
    ); 
  }
}

class Hamberger extends StatefulWidget {
  @override
  _HambergerState createState() => _HambergerState();
}

class _HambergerState extends State<Hamberger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text("Deliver Me"),
            leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            actions: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            ],
          ),
            Header(),
            Categories(),
            HamburgersList(row: 1),
            HamburgersList(row: 2),
          ],
       ), 
       extendBody: true, 
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(
        onPressed: () {},
         child: Icon(
          Icons.home
          ), 
        ),
       bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45),
          ), 
       child: Container(
        color: Colors.black38,
        child: BottomAppBar(
          color: Colors.teal,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            Spacer(),
            IconButton(
              icon: Icon(Icons.add_alert), 
              color: Colors.white,
              onPressed: () {},
              ), 
            Spacer(),
            Spacer(),
            IconButton(
              icon: Icon(Icons.turned_in), 
              color: Colors.white,
              onPressed: () {},
              ), 
              Spacer(), 
              ],
            ), 
          ), 
        ),
      ), 
    ); 
  }
}