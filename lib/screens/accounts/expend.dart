import 'package:flutter/material.dart';
import 'package:money_management/components/empty_data.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/screens/accounts/components/expend_date_list.dart';
import 'package:money_management/screens/create_expend/create_expend.dart';
import 'package:money_management/utils/data_format.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:provider/provider.dart';

class Expend extends StatefulWidget {
  const Expend({super.key, required this.accountId, required this.accountName});
  final String accountId;
  final String accountName;
  @override
  _ExpendState createState() => _ExpendState();
}

class _ExpendState extends State<Expend> {
  @override
  void initState() {
    super.initState();
    context.read<ExpendProvider>().getAllExpend(widget.accountId);
  }

  renderExpendList(ExpendProvider expendProviderData) {
    return isEmptyData(expendProviderData.expendList)
        ? const EmptyData()
        : ExpendDateList(
            expendListGroupByDate:
                groupAndFormatByDate(expendProviderData.expendList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        title: Text(
          widget.accountName,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFefeff2),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('30 ngày gần nhất',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w600)),
                  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.green)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Số dư hiện tại',
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  Text('44.444.440 đ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Expanded(
                child: Consumer<ExpendProvider>(
                    builder: (context, expendProviderData, child) =>
                        renderExpendList(expendProviderData)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Colors.green,
        elevation: 0,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => CreateExpend(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.green),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
