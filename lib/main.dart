import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_management/components/loading.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:money_management/screens/main_screen/main_screen.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:toastification/toastification.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await initializeDateFormatting('vi_VN', '');
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..indicatorSize = 45.0
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final sharedPrefService = serviceLocator<UserStorage>();

  bool isLoggedIn() {
    String? userId = sharedPrefService.getUserId();
    return userId != null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(context),
        ),
        ChangeNotifierProvider<AccountProvider>(
          create: (context) => AccountProvider(context),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(context),
        ),
        ChangeNotifierProvider<ExpendProvider>(
          create: (context) => ExpendProvider(context),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: LoadingOverlay(
              child: isLoggedIn() ? MainScreen() : LoginScreen()),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
