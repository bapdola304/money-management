import 'package:flutter/material.dart';
import 'package:money_management/components/empty_data.dart';
import 'package:money_management/screens/home/components/category.dart';
import 'package:money_management/screens/home/components/expend_board.dart';
import 'package:money_management/screens/home/components/expend_history.dart';
import 'package:money_management/screens/home/components/home_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            const ExpendBoard(),
            const SizedBox(height: 20),
            CategoryList(),
            const Text('Lịch sử chi tiêu',
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            const Expanded(
              child: true ? ExpendHistory() : EmptyData(),
            )
          ],
        ),
      ),
    );
  }
}
