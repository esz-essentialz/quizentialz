import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._();

  static late SharedPreferences pref;
  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
}
