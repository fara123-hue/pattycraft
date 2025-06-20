// hamberger_list.dart
import 'package:flutter/material.dart';
import 'package:pattycraft/burger_page.dart';
import 'package:pattycraft/services/api_service.dart';

class HamburgersList extends StatefulWidget {
  final String query;
  HamburgersList({required this.query});

  @override
  _HamburgersListState createState() => _HamburgersListState();
}

class _HamburgersListState extends State<HamburgersList> {
  List<dynamic> _burgers = [];
  bool _isLoading = true;

  @override
  void didUpdateWidget(covariant HamburgersList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      _fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await ApiService.fetchBurgers(widget.query);
      setState(() {
        _burgers = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _burgers = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: 330,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _burgers.length,
                itemBuilder: (context, index) {
                  final burger = _burgers[index];
                  return Stack(
                    children: [
                      Container(
                        height: 240,
                        width: 200,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: index == _burgers.length - 1 ? 20 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(BurgerPage.tag);
                          },
                          child: Card(
                            color: Colors.brown.shade800,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    burger['strMeal'] ?? 'Burger',
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
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 25,
                        child: burger['strMealThumb'] != null
                            ? Image.network(
                                burger['strMealThumb'],
                                width: 150,
                                height: 120,
                              )
                            : SizedBox(),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
