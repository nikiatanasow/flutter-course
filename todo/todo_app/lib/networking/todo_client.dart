import 'dart:convert';

import 'package:todo_app/models/todo_item.dart';

import 'package:http/http.dart' as http;

enum HTTP_METHOD { GET, POST, PUT, DELETE }

const BASE_URL = 'https://flutter-course-todo-api.herokuapp.com/todos';
const Map<String, String> DEFAULT_HEADERS = {
  'Content-type': 'application/json',
};

class TodoClient {
  static Future _makeRequest(
      {HTTP_METHOD method,
      String query = '',
      String path = '',
      Object body}) async {

    Future request;
    switch (method) {
      case HTTP_METHOD.GET:
        request = http.get('$BASE_URL?$query');
        break;
      case HTTP_METHOD.POST:
        request = http.post('$BASE_URL',
            headers: DEFAULT_HEADERS, body: jsonEncode(body));
        break;
      case HTTP_METHOD.PUT:
        request = http.put('$BASE_URL/$path',
            headers: DEFAULT_HEADERS, body: jsonEncode(body));
        break;
      case HTTP_METHOD.DELETE:
        request = http.delete('$BASE_URL/$path');
        break;
      default:
        break;
    }

    final response = await request;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      throw Exception('Failed to $method todos');
    }
  }

  static Future<List<TodoItem>> fetchTodos({String query = ''}) async {
    final response =
        await _makeRequest(method: HTTP_METHOD.GET, query: query);
    final json = jsonDecode(response) as List;
    return json.map((e) => TodoItem.fromJson(e)).toList();
  }

  static Future<TodoItem> addTodo(TodoItem item) async {
    final response =
        await _makeRequest(method: HTTP_METHOD.POST, body: item);

    return TodoItem.fromJson(jsonDecode(response));
  }

  static Future<TodoItem> removeTodo(String id) async {
    final response =
        await _makeRequest(method: HTTP_METHOD.DELETE, path: id);

    return TodoItem.fromJson(jsonDecode(response));
  }

  static Future<TodoItem> updateTodo(TodoItem item) async {
    final response =
        await _makeRequest(method: HTTP_METHOD.PUT, path: item.id, body: item);

    return TodoItem.fromJson(jsonDecode(response));
  }
}
