import 'package:flutter/material.dart';
import 'package:pattycraft/burger_page.dart';
import 'package:pattycraft/services/api_service.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';

class HamburgersList extends StatefulWidget {
  final String query;

  HamburgersList({required this.query});

  @override
  _HamburgersListState createState() => _HamburgersListState();
}

class _HamburgersListState extends State<HamburgersList> {
  late Future<List<dynamic>> _futureMeals;

  @override
  void initState() {
    super.initState();
    _futureMeals = ApiService.fetchMeals(widget.query);
  }

  @override
  void didUpdateWidget(HamburgersList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      setState(() {
        _futureMeals = ApiService.fetchMeals(widget.query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<dynamic>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading meals'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found'));
          }

          final meals = snapshot.data!;

          return Container(
            height: 280,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Stack(
                  children: [
                    Container(
                      height: 240,
                      width: 200,
                      margin: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            BurgerPage.tag,
                            arguments: meal,
                          );
                        },
                        child: Card(
                          color: Colors.brown.shade800,
                          elevation: 3,
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text(
                                  meal['strMeal'] ?? 'Unknown',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "15.95 \$ CAN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<CartModel>(context, listen: false).addItem(meal);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${meal['strMeal']} ditambahkan ke keranjang'),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          meal['strMealThumb'] ?? '',
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
