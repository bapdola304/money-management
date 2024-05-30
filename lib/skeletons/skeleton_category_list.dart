import 'package:money_management/skeletons/skeleton_container.dart';
import 'package:flutter/material.dart';

class SkeletonCategoryList extends StatelessWidget {
  const SkeletonCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1, mainAxisSpacing: 15),
      shrinkWrap: true,
      itemCount: 15,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
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
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: SkeletonContainer.rounded(
                width: 90,
                height: 15,
              ),
            ),
            // IconButton(
            //     onPressed: onActionsPressed,
            //     icon: const Icon(Icons.more_vert, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
