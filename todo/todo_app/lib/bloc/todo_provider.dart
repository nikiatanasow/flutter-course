import 'dart:convert';

import 'package:todo_app/models/todo_item.dart';
import 'package:http/http.dart' as http;

class TodoProvider {
  List<TodoItem> _items;

  TodoProvider(Function(List<TodoItem>) loadItemsFunc) {
    _items = List<TodoItem>();
    fetchTodos().then((items) => loadItemsFunc(items));
  }

  List<TodoItem> get items {
    return List.unmodifiable(_items); // http get
  }

  void addItem({TodoItem item, int index = -1}) {
    if (index != -1) {
      _items.insert(index, item);
    } else {
      _items.add(item);
    }
  }

  void removeItem({TodoItem item, int index = -1}) {
    if (index != -1) {
      _items.removeAt(index);
    } else {
      _items.remove(item);
    }
  }

  void updateItem(TodoItem item, TodoItem oldItem) {
    final realIndex = _items.indexOf(oldItem);
    _items.removeAt(realIndex);
    _items.insert(realIndex, item);
  }

  void update(List<TodoItem> items) {
    _items = List<TodoItem>()..addAll(items);
  }

  Future<List<TodoItem>> fetchTodos() async {
    final response =
        await http.get('https://flutter-course-todo-api.herokuapp.com/todos');

    if (response.statusCode == 200) {
      // iterate
      final json = jsonDecode(response.body) as List;
      return json.map((e) => TodoItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
