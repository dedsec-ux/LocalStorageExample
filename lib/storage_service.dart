import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class StorageService {
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks') ?? '[]';
    List<dynamic> tasksJson = json.decode(tasksString);
    return tasksJson.map((task) => Task.fromJson(task)).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksString);
  }
}
