import 'package:flutter/material.dart';
import 'package:money_management/components/empty_data.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/screens/home/components/category.dart';
import 'package:money_management/screens/home/components/expend_board.dart';
import 'package:money_management/screens/home/components/expend_history.dart';
import 'package:money_management/screens/home/components/home_app_bar.dart';
import 'package:money_management/skeletons/skeleton_expend_list_date.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userId = serviceLocator<UserStorage>().getUserId() ?? "";
    String startDate =
        DateTime.now().subtract(const Duration(days: 6)).toIso8601String();
    String endDate = DateTime.now().toIso8601String();
    Future.delayed(Duration.zero, () async {
      Provider.of<ExpendProvider>(context, listen: false)
          .getExpendsByDate(startDate, endDate, userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: HomeAppBar()),
      body: Container(
        color: const Color(0xFFefeff2),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Consumer<ExpendProvider>(
                builder: (context, expendProviderData, child) => ExpendBoard(
                    isLoading: expendProviderData.loading,
                    expendList: expendProviderData.expendListByDate)),
            const SizedBox(height: 20),
            CategoryList(),
            const Text('Lịch sử thu chi',
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            Consumer<ExpendProvider>(
                builder: (context, expendProviderData, child) => Expanded(
                    child: expendProviderData.loading
                        ? const SkeletonExpendListDate()
                        : isEmptyData(expendProviderData.expendListByDate)
                            ? const EmptyData()
                            : ExpendHistory(
                                expendList:
                                    expendProviderData.expendListByDate)))
          ],
        ),
      ),
    );
  }
}
