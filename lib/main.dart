import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'header.dart';
import 'categories.dart';
import 'hamberger_list.dart';
import 'burger_page.dart';
import 'models/cart_model.dart';
import 'cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MyApp(),
    ),
  );
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
          centerTitle: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      home: Hamberger(),
      routes: {
        BurgerPage.tag: (_) => BurgerPage(),
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
  String _searchQuery = "";
  String _selectedCategory = "Burger";

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = category; // update juga query pencarian
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text("Deliver Me"),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => Container(
                    height: 200,
                    child: Center(
                      child: Text("Menu belum tersedia"),
                    ),
                  ),
                );
              },
            ),
            actions: [
              Consumer<CartModel>(
                builder: (context, cart, _) {
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 0, end: 3),
                    badgeContent: Text(
                      cart.totalItems.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CartPage()),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          Header(onSearch: _onSearch),
          Categories(onCategorySelected: _onCategorySelected),
          HamburgersList(query: _searchQuery),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kembali ke beranda")),
          );
        },
        child: Icon(Icons.home),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Tidak ada notifikasi")),
                    );
                  },
                ),
                Spacer(),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.turned_in),
                  color: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bookmark belum tersedia")),
                    );
                  },
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
