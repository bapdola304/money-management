import 'package:money_management/skeletons/skeleton_container.dart';
import 'package:flutter/material.dart';

class SkeletonCategoryExpend extends StatelessWidget {
  const SkeletonCategoryExpend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text('Mục hay dùng',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500))),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1.3, mainAxisSpacing: 8),
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const SkeletonContainer.circular(
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: SkeletonContainer.rounded(
                    width: 80,
                    height: 15,
                  ),
                ),
                // IconButton(
                //     onPressed: onActionsPressed,
                //     icon: const Icon(Icons.more_vert, color: Colors.black)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
