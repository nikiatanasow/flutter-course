import 'dart:collection';

import 'package:todo_app/models/todo_item.dart';

class TodoProvider {
  List<TodoItem> _items;

  TodoProvider() {
    _items = List<TodoItem>();
  }

  UnmodifiableListView<TodoItem> get items {
    return UnmodifiableListView(_items);
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
}
