import 'package:money_management/storage/shared_preferences_service.dart';

const String _kUserIdKey = 'user_id';
const String _kUsernameKey = 'username';
const String _kFullNameKey = 'full_name';

class UserStorage extends SharedPreferencesService {
  UserStorage._();

  static Future<UserStorage> getInstance() async {
    await SharedPreferencesService.getInstance();
    return UserStorage._();
  }

  // Save user data
  void saveUserData(String? userId, String? username, String? fullName) {
    saveData(_kUserIdKey, userId);
    saveData(_kUsernameKey, username);
    saveData(_kFullNameKey, fullName);
  }

  // Retrieve user data
  String? getUserId() {
    return getData(_kUserIdKey) as String?;
  }

  String? getUsername() {
    return getData(_kUsernameKey) as String?;
  }

  String? getFullName() {
    return getData(_kFullNameKey) as String?;
  }

  // Clear user data
  void clearUserData() {
    removeData(_kUserIdKey);
    removeData(_kUsernameKey);
    removeData(_kFullNameKey);
  }
}
