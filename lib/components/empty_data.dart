import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/no_data.svg', width: 120),
        const SizedBox(height: 10),
        const Text(
          'Dữ liệu trống',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black38),
        )
      ],
    );
  }
}
