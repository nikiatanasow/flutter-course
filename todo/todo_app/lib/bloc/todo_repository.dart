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
      return this.markItemCompleted(item, completed);
    }));
  }

  Future dismiss(TodoItem item) async {
    await provider.removeItem(item: item);
  }

  Future undoDismiss(TodoItem item) async {
    await provider.addItem(item: item);
  }

  Future markItemCompleted(TodoItem item, bool isCompleted) async {
    final changedTodoItem = item.copy(isCompleted: isCompleted);

    return provider.updateItem(changedTodoItem);
  }
}
