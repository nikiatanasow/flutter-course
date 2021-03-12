import 'package:todo_app/bloc/todo_provider.dart';
import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoRepository {
  TodoProvider provider;
  FilterPopupItem currentFilterStatus;

  TodoRepository(Function(List<TodoItem>) loadItems) {
    provider = TodoProvider((items) => loadItems(items));
  }

  List<TodoItem> filter(FilterPopupItem filter) {
    currentFilterStatus = filter;

    if (filter == FilterPopupItem.all) {
      // return provider.items;
      return [];
    }

    // if (filter == FilterPopupItem.active) {
    //   return provider.items
    //       .where((element) =>
    //           element.isCompleted == false || element.isCompleted == null)
    //       .toList();
    // }

    // if (filter == FilterPopupItem.completed) {
    //   return provider.items
    //       .where((element) => element.isCompleted == true)
    //       .toList();
    // }

    return null;
  }

  Future mark(bool completed) async {
    // List<TodoItem> items;
    // if (completed) {
    //   items = provider.items.map((e) => e.copy(isCompleted: true)).toList();
    // } else {
    //   items = provider.items.map((e) => e.copy(isCompleted: false)).toList();
    // }

    // provider.update(items);

    // items = filter(currentFilterStatus);

    // return items;

    final items = await provider.items;

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
    // await provider.removeItem(item: item, index: index);
    // provider.addItem(item: changedTodoItem, index: index);

    await provider.updateItem(changedTodoItem, null);
  }
}
