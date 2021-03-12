import 'dart:convert';

import 'package:todo_app/models/todo_item.dart';
import 'package:http/http.dart' as http;

// add - DONE
// get - DONE
// delete - DELETE
// update - DONE
// mark - DONE
// filter
// undo
// refresh

class TodoProvider {
  List<TodoItem> _items;

  TodoProvider(Function(List<TodoItem>) loadItemsFunc) {
    _items = List<TodoItem>();
    fetchTodos().then((items) => loadItemsFunc(items));
  }

  Future<List<TodoItem>> get items async {
    // return List.unmodifiable(_items); // http get
    return fetchTodos();
  }

  Future addItem({TodoItem item, int index = -1}) async {
    await this.addTodo(item);
  }

  Future removeItem({TodoItem item, int index = -1}) async {
    // if (index != -1) {
    //   _items.removeAt(index);
    // } else {
    //   _items.remove(item);
    // }

    await removeTodo(item.id);
  }

  Future updateItem(TodoItem item, TodoItem oldItem) async {
    // final realIndex = _items.indexOf(oldItem);
    // _items.removeAt(realIndex);
    // _items.insert(realIndex, item);

    await updateTodo(item);
  }

  // this is for filtering
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
      throw Exception('Failed to load tod');
    }
  }

  Future<TodoItem> addTodo(TodoItem item) async {
    final jsonItem = jsonEncode(item);
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    final response = await http.post(
        'https://flutter-course-todo-api.herokuapp.com/todos',
        headers: headers,
        body: jsonItem);

    if (response.statusCode == 201) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<TodoItem> removeTodo(String id) async {
    final response = await http
        .delete('https://flutter-course-todo-api.herokuapp.com/todos/$id');

    if (response.statusCode == 200) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<TodoItem> updateTodo(TodoItem item) async {
    final jsonItem = jsonEncode(item);
    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    final response = await http.put(
        'https://flutter-course-todo-api.herokuapp.com/todos/${item.id}',
        headers: headers,
        body: jsonItem);

    if (response.statusCode == 200) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }
}
