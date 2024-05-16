import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpendBoard extends StatelessWidget {
  const ExpendBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.green),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tổng chi tiêu',
                  style: TextStyle(fontSize: 16, color: Colors.white70)),
              Text('\$ 500.000đ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))
            ],
          ),
          SvgPicture.asset(
            'assets/icons/data.svg',
            width: 120,
          )
        ],
      ),
    );
  }
}
