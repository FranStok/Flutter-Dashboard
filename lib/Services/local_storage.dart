import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  //Libreria SharedPreferences.
  static late SharedPreferences prefs;

  static Future<void>configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
