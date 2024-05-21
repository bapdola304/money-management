import 'package:flutter/material.dart';

class CategoryTabList extends StatelessWidget {
  const CategoryTabList({Key? key, this.onActionsPressed, this.onItemClicked})
      : super(key: key);
  final Function()? onActionsPressed;
  final Function()? onItemClicked;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1, mainAxisSpacing: 15),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => InkWell(
        onTap: onItemClicked,
        onLongPress: onActionsPressed,
        child: Container(
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
                child: Image.asset(
                  'assets/icons/wallet.png',
                  width: 50,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text('Trang phục',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
              // IconButton(
              //     onPressed: onActionsPressed,
              //     icon: const Icon(Icons.more_vert, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
