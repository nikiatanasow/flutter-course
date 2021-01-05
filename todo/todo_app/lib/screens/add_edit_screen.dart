import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';

class AddEditScreen extends StatefulWidget {
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  TextEditingController _titleContoller;
  TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _titleContoller = TextEditingController();
    _detailsController = TextEditingController();
  }

  @override
  void dispose() {
    _titleContoller.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              final title = _titleContoller.text;
              final details = _detailsController.text;

              final todoItem = TodoItem(
                title: title,
                details: details,
              );

              Navigator.of(context).pop(todoItem);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleContoller,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: _detailsController,
            decoration: const InputDecoration(
              hintText: 'Details',
              alignLabelWithHint: true,
              hintMaxLines: 5,
            ),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
