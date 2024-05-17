import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/accounts.dart';
import 'package:money_management/screens/create_category/create_category.dart';
import 'package:money_management/screens/create_expend/create_expend.dart';
import 'package:money_management/screens/home/home.dart';
import 'package:money_management/screens/main_screen/nav_bar.dart';
import 'package:money_management/screens/main_screen/nav_model.dart';
import 'package:money_management/screens/profile/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const Home(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const Accounts(),
        navKey: searchNavKey,
      ),
      NavModel(
        page: const CreateCategory(),
        navKey: notificationNavKey,
      ),
      NavModel(
        page: const Profile(),
        navKey: profileNavKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateExpend(),
              ),
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
