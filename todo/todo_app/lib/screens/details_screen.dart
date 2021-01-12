import 'package:flutter/material.dart';
import 'package:todo_app/models/edited_item.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/add_edit_screen.dart';

class DetailsScreen extends StatefulWidget {
  final TodoItem item;

  const DetailsScreen({Key key, @required this.item}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TodoItem _item;
  bool _isEdited;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Details'),
        leading: BackButton(
          onPressed: () {
            if (_isEdited == true) {
              Navigator.of(context).pop(
                EditedItem(
                  operation: ItemOperation.Edit,
                  item: _item,
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(
                EditedItem(
                  operation: ItemOperation.Delete,
                  item: _item,
                ),
              );
            },
          ),
        ],
      ),
      body: ListTile(
        title: Text(_item.title),
        subtitle: Text(_item.details),
        leading: Checkbox(
          onChanged: null,
          value: _item.isCompleted ?? false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(
                item: _item,
              ),
            ),
          );
          if (result != null) {
            _isEdited = true;
            _item = result;
            setState(() {});
          }
        },
      ),
    );
  }
}
