import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/components/dialog_confirm.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/enum.dart';
import 'package:provider/provider.dart';

class ExpendCategoryList extends StatelessWidget {
  final Function()? onItemClicked;
  const ExpendCategoryList(
      {Key? key,
      this.onItemClicked,
      required this.expendListGroupByCategory,
      required this.accountId})
      : super(key: key);
  final List<Map<String, dynamic>> expendListGroupByCategory;
  final String accountId;

  void onDeleteExpend(BuildContext context, dynamic expendItem) {
    showDialogConfirm(context, 'Bạn có muốn xóa bản ghi chép này?', () {
      onConfirm(context, expendItem['id']);
    });
  }

  void onConfirm(BuildContext context, String expendId) {
    context.read<ExpendProvider>().deleteExpend(expendId).then((response) {
      if (response.statusCode == 204) {
        showToastification('Xóa bản ghi thành công!', 'success', context);
        context.read<ExpendProvider>().getAllExpend(accountId);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: expendListGroupByCategory.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        dynamic expendItem = expendListGroupByCategory[index];
        return Material(
          color: Colors.white,
          child: InkWell(
            onTap: onItemClicked,
            onLongPress: () => onDeleteExpend(context, expendItem),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 40, top: 10, bottom: 15, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      base64String: expendItem['category']['icon']['image'],
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(expendItem['category']['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formatCurrency(expendItem['amount'], true),
                    style: TextStyle(
                        fontSize: 18,
                        color: expendItem['transactionType'] ==
                                TransactionType.income.toString()
                            ? Colors.green[400]
                            : Colors.red[400]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
