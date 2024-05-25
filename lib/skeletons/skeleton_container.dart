import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  const SkeletonContainer.square({
    double? width,
    double? height,
  }) : this._(width: width ?? 30, height: height ?? 30);

  const SkeletonContainer.rounded({
    double? width,
    double? height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(
            width: width ?? 30,
            height: height ?? 30,
            borderRadius: borderRadius);

  const SkeletonContainer.circular({
    double? width,
    double? height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(
            width: width ?? 30,
            height: height ?? 30,
            borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        //gradientColor: Colors.orange,
        //shimmerColor: Colors.red,
        //curve: Curves.easeInQuad,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: borderRadius,
          ),
        ),
      );
}
