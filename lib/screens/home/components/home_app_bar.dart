import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/utils/date_format.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String date = getCurrentDateTime();
    return Container(
      color: const Color(0xFFF5F5F8),
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: AppBar(
        surfaceTintColor: const Color(0xFFF5F5F8),
        backgroundColor: const Color(0xFFF5F5F8),
        leading: SvgPicture.asset('assets/icons/avatar.svg'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào, H2 Family',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text('Hôm nay, $date',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none_rounded),
        ],
      ),
    );
  }
}
