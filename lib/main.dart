import 'package:flutter/material.dart';
import 'package:money_management/components/loading_overlay.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:toastification/toastification.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: LoadingOverlay(child: LoginScreen()),
        ),
      ),
    );
  }
}
