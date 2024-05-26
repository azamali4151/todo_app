import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Todo>> fetchTodos({int limit = 5}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Todo> todos = body.map((dynamic item) => Todo.fromJson(item)).toList();
      return todos.take(limit).toList();  // Limit the number of items to 'limit'
    } else {
      throw "Failed to load todos";
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw "Failed to create todo";
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw "Failed to delete todo";
    }
  }
}
