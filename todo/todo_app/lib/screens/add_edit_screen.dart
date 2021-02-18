import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
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

    // _titleContoller = TextEditingController(text: widget.item?.title);
    // _detailsController = TextEditingController(text: widget.item?.details);
  }

  @override
  void dispose() {
    _titleContoller.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      builder: (context, state) {
        TodoItem item;
        if (state is TodoItemEditState) {
          item = state.item;
        }

        _titleContoller = TextEditingController(text: item?.title);
        _detailsController = TextEditingController(text: item?.details);

        return Scaffold(
          appBar: AppBar(
            title: Text(item == null ? 'Add Todo' : 'Edit Todo'),
            actions: [
              IconButton(
                icon: Icon(
                  item == null ? Icons.save : Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  final title = _titleContoller.text;
                  final details = _detailsController.text;

                  final todoItem = TodoItem(
                    title: title,
                    details: details,
                    isCompleted: item?.isCompleted,
                  );

                  if (item == null) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(AddTodoItemEvent(item: todoItem));
                  } else {
                    BlocProvider.of<TodoBloc>(context)
                        .add(EditTodoItemEvent(item: todoItem, oldItem: item));
                  }

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
      },
    );
  }
}
