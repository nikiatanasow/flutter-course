import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/todo_item.dart';

class AddEditScreen extends StatefulWidget {
  @override
    AddEditScreenState createState() => AddEditScreenState();
}

 class AddEditScreenState extends State<AddEditScreen> {
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
        title: Text("Add Todo"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: saveTodo)
                  ],
                  ),
                body: Column(
                  children: [
                    TextField(
                      controller: _titleContoller,
                      decoration: const InputDecoration(
                        hintText: "Title"
                      ),
                    ),
                    TextField(
                      controller: _detailsController,
                      decoration: const InputDecoration(
                        hintText: "Details"
                      ),
                    )
                  ],
                ),
              );
            }
           
            void saveTodo() {
              final TodoItem newItem = TodoItem(title: _titleContoller.text, details: _detailsController.text);
              Navigator.of(context).pop(newItem);
  }
}