import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/model/category.dart';

class CategoryTabList extends StatelessWidget {
  const CategoryTabList(
      {super.key,
      this.onActionsPressed,
      this.onItemClicked,
      required this.categoryList});
  final Function(CategoryModel category)? onActionsPressed;
  final Function()? onItemClicked;
  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1, mainAxisSpacing: 15),
      shrinkWrap: true,
      itemCount: categoryList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: onItemClicked,
        onLongPress: () => onActionsPressed!(categoryList[index]),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                      base64String: categoryList[index].icon?.image,
                      width: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(categoryList[index].name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            categoryList[index].isFavorite
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset('assets/icons/favorite.png', width: 20))
                : Container(),
          ],
        ),
      ),
    );
  }
}
