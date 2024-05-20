import 'package:flutter/material.dart';
import 'package:money_management/components/loading.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:toastification/toastification.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..indicatorSize = 45.0
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(context),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: LoadingOverlay(child: LoginScreen()),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
