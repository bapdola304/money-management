import 'package:flutter/material.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/screens/accounts/accounts.dart';
import 'package:money_management/screens/category/category.dart';
import 'package:money_management/screens/create_expend/create_expend.dart';
import 'package:money_management/screens/home/home.dart';
import 'package:money_management/screens/main_screen/nav_model.dart';
import 'package:money_management/screens/navigation/custom_tab_bar.dart';
import 'package:money_management/screens/profile/profile.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:provider/provider.dart';

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
  bool isClickedCreateExpend = false;
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
        page: Container(),
        navKey: searchNavKey,
      ),
      NavModel(
        page: const Category(),
        navKey: notificationNavKey,
      ),
      NavModel(
        page: const Profile(),
        navKey: profileNavKey,
      ),
    ];
  }

  navigationToCreateExpend() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateExpend(isCreateFromBottomMenu: true),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    isClickedCreateExpend = false;
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
        bottomNavigationBar: CustomTabBar(
          onTabChange: (int tabIndex) {
            setState(() {
              selectedTab = tabIndex;
            });
          },
        ),
        body: items[selectedTab].page,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 64,
          width: 64,
          child: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
            child: Consumer<AccountProvider>(
              builder: (context, accountProviderData, child) =>
                  FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 0,
                onPressed: () async {
                  if (accountProviderData.accounts.isNotEmpty) {
                    navigationToCreateExpend();
                    return;
                  }
                  isClickedCreateExpend = true;
                  String userId =
                      serviceLocator<UserStorage>().getUserId() ?? "";
                  int counts =
                      await Provider.of<AccountProvider>(context, listen: false)
                          .getAccountCounts(userId);
                  if (counts == 0) {
                    return showToastification(
                        'Vui lòng tạo tài khoản để ghi thu chi!',
                        'warning',
                        context);
                  } else {
                    navigationToCreateExpend();
                  }
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 3, color: Colors.green),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: accountProviderData.loading && isClickedCreateExpend
                    ? const CircularProgressIndicator(color: Colors.green)
                    : const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
