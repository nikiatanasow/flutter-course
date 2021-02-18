import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/add_edit_screen.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      builder: (context, state) {
        TodoItem item;
        if (state is TodoItemEditState) {
          item = state.item;
        }
        if (item == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('ToDo Details'),
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<TodoBloc>(context)
                      .add(DeleteTodoItemEvent(item: item));
                },
              ),
            ],
          ),
          body: ListTile(
            title: Text(item.title),
            subtitle: Text(item.details),
            leading: Checkbox(
              onChanged: null,
              value: item.isCompleted ?? false,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
