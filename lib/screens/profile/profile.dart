import 'package:flutter/material.dart';
import 'package:money_management/provider/app_provider.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sharedPrefService = serviceLocator<UserStorage>();
  String fullName = serviceLocator<UserStorage>().getFullName() ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Thông tin của bạn',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset('assets/icons/avatar.svg', width: 130),
                const SizedBox(height: 10),
                Text(
                  fullName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.info_outline_rounded,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Thông tin tài khoản',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Cài đặt',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                sharedPrefService.clearUserData();
                AppProviders.disposeAllDisposableProviders(context);
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.logout_rounded,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Đăng xuất',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
