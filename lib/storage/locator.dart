import 'package:get_it/get_it.dart';
import 'package:money_management/storage/user_storage.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register services
  final sharedPreferencesService = await UserStorage.getInstance();
  serviceLocator.registerSingleton(sharedPreferencesService);
}
