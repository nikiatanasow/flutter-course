import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/networking/todo_client.dart';

class TodoProvider {
  TodoProvider(Function(List<TodoItem>) loadItemsFunc) {
    TodoClient.fetchTodos().then((items) => loadItemsFunc(items));
  }

  Future<List<TodoItem>> fetchItems(
      {FilterPopupItem filter = FilterPopupItem.all}) async {
    var query;

    switch (filter) {
      case FilterPopupItem.active:
        query =
            'isCompleted=false'; // TODO: extract the isCompleted word in variable
        break;
      case FilterPopupItem.completed:
        query = 'isCompleted=true';
        break;
      default:
        query = '';
        break;
    }

    return TodoClient.fetchTodos(query: query);
  }

  Future addItem({TodoItem item}) async {
    return TodoClient.addTodo(item);
  }

  Future removeItem({TodoItem item, int index = -1}) async {
    return TodoClient.removeTodo(item.id);
  }

  Future updateItem(TodoItem item) async {
    await TodoClient.updateTodo(item);
  }
}
