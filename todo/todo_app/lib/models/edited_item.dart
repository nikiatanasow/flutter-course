import 'package:todo_app/models/todo_item.dart';

class EditedItem {
  final TodoItem item;
  final ItemOperation operation;

  const EditedItem({this.item, this.operation});
}

enum ItemOperation { Delete, Edit }
