import 'package:money_management/skeletons/skeleton_container.dart';
import 'package:flutter/material.dart';

class SkeletonAccountList extends StatelessWidget {
  const SkeletonAccountList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) =>
          const SkeletionAccountItem(),
    );
  }
}

class SkeletionAccountItem extends StatelessWidget {
  const SkeletionAccountItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
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
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 25,
                ),
                const SizedBox(height: 8),
                const SkeletonContainer.rounded(
                  width: 60,
                  height: 13,
                ),
              ],
            ),
          ),
          const SkeletonContainer.rounded(
            width: 5,
            height: 20,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
