import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final Function(String) onSearch;

  Header({required this.onSearch});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: size.height / 5,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(45),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 2),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 35,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/dog.jpg"),
                            radius: 30,
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FARADILA",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black54,
                              ),
                              child: Text(
                                "GOLD Member",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "154 \$ CAN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 50,
              width: size.width,
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (_) => _onSearch(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "What does your belly want to eat?",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _onSearch,
                    ),
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
