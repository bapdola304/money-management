import 'package:flutter/material.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sharedPrefService = serviceLocator<UserStorage>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Button(
            textButton: 'Logout',
            onButtonPressed: () {
              sharedPrefService.clearUserData();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
            bgColor: Colors.green),
      ),
    );
  }
}
