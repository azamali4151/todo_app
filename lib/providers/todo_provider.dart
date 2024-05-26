import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoProvider with ChangeNotifier {
  ApiService _apiService = ApiService();
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  TodoProvider() {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    _todos = await _apiService.fetchTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    Todo newTodo = await _apiService.createTodo(todo);
    _todos.add(newTodo);
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _apiService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      print("Failed to delete todo: $e");
    }
  }
}
