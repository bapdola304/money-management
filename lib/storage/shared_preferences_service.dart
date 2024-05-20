import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService();

  // Using a singleton pattern
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService();

    _preferences = await SharedPreferences.getInstance();

    return _instance!;
  }

  dynamic getData(String key) {
    // Retrieve data from shared preferences
    var value = _preferences.get(key);
    // Return the data that we retrieve from shared preferences
    return value;
  }

  void saveData(String key, dynamic value) {
    // Save data to shared preferences
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  void removeData(String key) {
    _preferences.remove(key);
  }
}
