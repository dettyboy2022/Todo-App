import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageMethods {
  static saveTask(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('listkey', []);
  }

  // static getTask() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> listkey = prefs.setStringList('listkey') ?? [];
  // }

  // static Future<bool> saveTask(String todo) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   bool res = await prefs.setString('saveTodo', todo);

  //   return res;
  // }

  // static Future<String?> getTask() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? res;
  //   if (prefs.containsKey('saveTodo')) {
  //     res = prefs.getString('saveTodo');
  //   }
  //   return res;
  // }
}
