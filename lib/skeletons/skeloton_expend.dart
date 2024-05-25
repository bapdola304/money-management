import 'package:money_management/skeletons/skeleton_container.dart';
import 'package:flutter/material.dart';

class SkeletonExpend extends StatelessWidget {
  const SkeletonExpend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: Colors.white,
          width: screenWidth,
          height: 50,
          child: Center(
            child: SkeletonContainer.rounded(
              height: 20,
              width: screenWidth * 0.5,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 60,
              color: Colors.white,
              width: screenWidth * 0.5 - 2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tổng thu',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SkeletonContainer.rounded(
                    width: 140,
                    height: 20,
                  )
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              height: 60,
              color: Colors.white,
              width: screenWidth * 0.5 - 2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tổng chi',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  SkeletonContainer.rounded(
                    width: 140,
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Container(
          color: Colors.white,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Số dư hiện tại',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              SkeletonContainer.rounded(
                height: 25,
                width: screenWidth * 0.4,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) =>
                const SkeletionExpendItem(),
          ),
        ),
      ],
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
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 16),
                    SkeletonContainer.circular(
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonContainer.rounded(
                            width: 70,
                            height: 20,
                          ),
                          SizedBox(height: 8),
                          SkeletonContainer.rounded(
                            width: 60,
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    SkeletonContainer.rounded(
                      width: 120,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
