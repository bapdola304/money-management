import 'package:flutter/material.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/utils/data_utils.dart';

class CategoryBottomSheet extends StatelessWidget {
  final Function() onEditPressed;
  final Function() onDeletePressed;
  final Function() onUpdateFavoritePressed;
  final CategoryModel? categorySelected;
  const CategoryBottomSheet(
      {super.key,
      required this.onDeletePressed,
      required this.onEditPressed,
      this.categorySelected,
      required this.onUpdateFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onEditPressed();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      Text(
                        'Sửa',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onDeletePressed();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10),
                      Text(
                        'Xóa',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onUpdateFavoritePressed();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded),
                      SizedBox(width: 10),
                      Text(
                        categorySelected!.isFavorite
                            ? 'Xóa khỏi mục hay dùng'
                            : 'Thêm vào mục hay dùng',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
