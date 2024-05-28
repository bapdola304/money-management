import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/model/category.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList(
      {Key? key,
      this.onItemClicked,
      required this.categorySelected,
      this.transactionTypeSelect,
      this.categoryList})
      : super(key: key);
  final Function(CategoryModel category)? onItemClicked;
  final CategoryModel categorySelected;
  final TransactionTypeSelect? transactionTypeSelect;
  final List<CategoryModel>? categoryList;
  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<CategoryModel> getFavoriteCategoryList(
      List<CategoryModel> categoryList) {
    return categoryList
        .where((item) =>
            item.isFavorite == true &&
            item.transactionType == widget.transactionTypeSelect!.value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryFavoriteList =
        getFavoriteCategoryList(widget.categoryList!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text('Mục hay dùng',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500))),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1.3, mainAxisSpacing: 8),
          shrinkWrap: true,
          itemCount: categoryFavoriteList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => widget.onItemClicked!(categoryFavoriteList[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color:
                    widget.categorySelected.id == categoryFavoriteList[index].id
                        ? Colors.green.withOpacity(0.4)
                        : Colors.white,
                border: Border.all(
                    color: widget.categorySelected.id ==
                            categoryFavoriteList[index].id
                        ? Colors.green.withOpacity(0.4)
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Base64ImageWidget(
                      base64String: categoryFavoriteList[index].icon?.image,
                      width: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(categoryFavoriteList[index].name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
