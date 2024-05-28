import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/model/home_date_category.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:provider/provider.dart';

// We need statefull widget because we are gonna change some state on our category
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  double kDefaultPadding = 20.0;
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    if (context.read<ExpendProvider>().categoryDateSelected.title.isNotEmpty) {
      setState(() {
        selectedIndex =
            context.read<ExpendProvider>().categoryDateSelected.index ?? 2;
      });
    }
    if (context.read<ExpendProvider>().expendListByDate.isNotEmpty) return;
    DateCategory categoryDataSelected = dateCategoryList[selectedIndex];
    String userId = serviceLocator<UserStorage>().getUserId() ?? "";
    String startDate = categoryDataSelected.startDate!;
    String endDate = categoryDataSelected.endDate!;
    Future.delayed(Duration.zero, () async {
      Provider.of<ExpendProvider>(context, listen: false)
          .getExpendsByDate(startDate, endDate, userId);
      context
          .read<ExpendProvider>()
          .setCategoryDateSelected(categoryDataSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateCategoryList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            DateCategory categoryDataSelected = dateCategoryList[index];
            String userId = serviceLocator<UserStorage>().getUserId() ?? "";
            String startDate = categoryDataSelected.startDate ?? "";
            String endDate = categoryDataSelected.endDate ?? "";
            context
                .read<ExpendProvider>()
                .setCategoryDateSelected(categoryDataSelected);
            Provider.of<ExpendProvider>(context, listen: false)
                .getExpendsByDate(startDate, endDate, userId);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding / 2,
              // At end item it add extra 20 right  padding
              right: index == dateCategoryList.length - 1 ? kDefaultPadding : 0,
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
              dateCategoryList[index].title,
              style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
