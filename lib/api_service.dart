import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos'; // Example API

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(Task task) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }
}
