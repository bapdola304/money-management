import 'package:flutter/material.dart';

// We need statefull widget because we are gonna change some state on our category
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  double kDefaultPadding = 20.0;
  int selectedIndex = 1;
  List categories = ['Tất cả', 'Hôm nay', 'Tuần trước', 'Tháng này'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding / 2,
              // At end item it add extra 20 right  padding
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == selectedIndex ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color:
                      index == selectedIndex ? Colors.green : Colors.black26),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
