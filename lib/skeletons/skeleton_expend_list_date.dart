import 'package:money_management/skeletons/skeleton_container.dart';
import 'package:flutter/material.dart';

class SkeletonExpendListDate extends StatelessWidget {
  const SkeletonExpendListDate({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) =>
          const SkeletionExpendItem(),
    );
  }
}

class SkeletionExpendItem extends StatelessWidget {
  const SkeletionExpendItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          const SkeletonContainer.circular(
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonContainer.rounded(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 15,
                ),
                const SizedBox(height: 8),
                const SkeletonContainer.rounded(
                  width: 120,
                  height: 13,
                ),
              ],
            ),
          ),
          const SkeletonContainer.rounded(
            width: 80,
            height: 20,
          ),
        ],
      ),
    );
  }
}
