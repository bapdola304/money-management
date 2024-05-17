import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/components/expend_date_list.dart';
import 'package:money_management/screens/create_expend/create_expend.dart';

class Expend extends StatefulWidget {
  const Expend({Key? key}) : super(key: key);

  @override
  _ExpendState createState() => _ExpendState();
}

class _ExpendState extends State<Expend> {
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
        title: const Text(
          'Tên tài khoản 1',
          style: TextStyle(
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
            const Expanded(child: ExpendDateList())
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
              builder: (context) => const CreateExpend(),
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
