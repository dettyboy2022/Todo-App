import 'package:shared_preferences/shared_preferences.dart';

class StorageMethods {
  static const String taskList = 'tasks';

  // save tasks
  static Future<void> saveTasks(List<String> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(taskList, tasks);
  }

  // get tasks
  static Future<List<String>> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(taskList) ?? [];
  }
}
