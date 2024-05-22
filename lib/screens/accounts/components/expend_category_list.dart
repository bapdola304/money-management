import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';

class ExpendCategoryList extends StatelessWidget {
  final Function()? onItemClicked;
  const ExpendCategoryList(
      {Key? key, this.onItemClicked, required this.expendListGroupByCategory})
      : super(key: key);
  final List<Map<String, dynamic>> expendListGroupByCategory;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expendListGroupByCategory.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Material(
        color: Colors.white,
        child: InkWell(
          onTap: onItemClicked,
          child: Container(
            margin:
                const EdgeInsets.only(left: 40, top: 10, bottom: 15, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Base64ImageWidget(
                  base64String: expendListGroupByCategory[index]['category']
                      ['icon']['image'],
                  width: 30,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Dịch vụ sinh hoạt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 8),
                Text(
                  expendListGroupByCategory[index]['amount'].toString(),
                  style: TextStyle(fontSize: 18, color: Colors.red[400]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
