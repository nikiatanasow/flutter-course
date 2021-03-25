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
      buildWhen: (prev, curr) =>
          curr.currentItem != prev.currentItem ||
          curr.isLoading != prev.isLoading,
      builder: (context, state) {
        final TodoItem item = state.currentItem;
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

                  BlocProvider.of<TodoBloc>(context).deleteItem(item);
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              ListTile(
                title: Text(item.title),
                subtitle: Text(item.details),
                leading: Checkbox(
                  onChanged: null,
                  value: item.isCompleted ?? false,
                ),
              ),
              if (state.isLoading)
                Container(
                  color: Colors.white38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
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
