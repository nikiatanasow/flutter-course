import 'package:todo_app/bloc/todo_provider.dart';
import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoRepository {
  TodoProvider provider;
  FilterPopupItem currentFilterStatus;

  TodoRepository(Function(List<TodoItem>) loadItems) {
    provider = TodoProvider((items) => loadItems(items));
  }

  Future<List<TodoItem>> filter(FilterPopupItem filter) async {
    currentFilterStatus = filter;

    return provider.fetchItems(filter: filter);
  }

  Future mark(bool completed) async {
    final items = await provider.fetchItems();

    await Future.wait(items.map((item) {
      return this.markItemCompleted(item, completed, 0);
    }));
  }

  Future dismiss(TodoItem item) async {
    await provider.removeItem(item: item);
  }

  void undoDismiss(TodoItem item, int index) {
    provider.addItem(item: item, index: index);
  }

  Future markItemCompleted(TodoItem item, bool isCompleted, int index) async {
    final changedTodoItem = item.copy(isCompleted: isCompleted);

    return provider.updateItem(changedTodoItem, null);
  }
}
