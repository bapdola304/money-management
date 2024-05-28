import 'package:flutter/material.dart';
import 'package:money_management/skeletons/skeleton_container.dart';

class SkeletonHomeBoard extends StatelessWidget {
  const SkeletonHomeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SkeletonContainer.rounded(
      width: 120,
      height: 29,
    );
  }
}
