
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final Function(String) onCategorySelected;

  Categories({required this.onCategorySelected});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int currentSelectedItem = 0;
  final List<String> categories = [
    'Burger', 'Pizza', 'Pasta', 'Tacos', 'Sushi', 'Steak', 'Salad', 
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 20 : 0,
                      right: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentSelectedItem = index;
                        });
                        widget.onCategorySelected(categories[index].toLowerCase());
                      },
                      child: Card(
                        color: index == currentSelectedItem
                            ? Colors.black.withOpacity(0.7)
                            : Colors.white,
                        child: Icon(
                          Icons.fastfood,
                          color: index == currentSelectedItem
                              ? Colors.white
                              : Colors.black.withOpacity(0.7),
                        ),
                        elevation: 3,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 20 : 0,
                    right: 20,
                  ),
                  width: 90,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(categories[index]),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
