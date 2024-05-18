/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';

class DropDownObjectChildWidget extends StatelessWidget {
  const DropDownObjectChildWidget({
    super.key,
    required this.categoryValueNotifier,
    this.firstSpace = 12,
    this.secondSpace = 16,
    this.padding,
    this.fontSize,
    this.coloredContainerSize,
    this.height,
  });

  final ValueNotifier<CategoryModel> categoryValueNotifier;
  final double firstSpace;
  final double secondSpace;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? coloredContainerSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      padding: padding ?? const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(color: Colors.white),
      height: height ?? 65,
      child: ValueListenableBuilder<CategoryModel>(
        valueListenable: categoryValueNotifier,
        builder: (_, CategoryModel project, __) {
          return Column(
            children: [
              Row(
                children: [
                  Image.asset(project.icon, width: 40),
                  SizedBox(width: firstSpace),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          '${project.name}',
                          key: ValueKey<String>('${project.name}'.trim()),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: secondSpace),
                  const Icon(Icons.keyboard_arrow_right_rounded),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
