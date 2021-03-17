import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/networking/todo_client.dart';

// add - DONE
// get - DONE
// delete - DELETE
// update - DONE
// mark - DONE
// filter - DONE
// refresh - pull to refresh - DONE
// refactor a little - DONE
// undo - wont do

class TodoProvider {
  TodoProvider(Function(List<TodoItem>) loadItemsFunc) {
    TodoClient.fetchTodos().then((items) => loadItemsFunc(items));
  }

  Future<List<TodoItem>> fetchItems({FilterPopupItem filter = FilterPopupItem.all}) async {
    var query;

    switch (filter) {
      case FilterPopupItem.active:
        query = 'isCompleted=false'; // TODO: extract the isCompleted word in variable
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

  Future addItem({TodoItem item, int index = -1}) async {
    return TodoClient.addTodo(item);
  }

  Future removeItem({TodoItem item, int index = -1}) async {
    return TodoClient.removeTodo(item.id);
  }

  Future updateItem(TodoItem item, TodoItem oldItem) async {
    await TodoClient.updateTodo(item);
  }
}
