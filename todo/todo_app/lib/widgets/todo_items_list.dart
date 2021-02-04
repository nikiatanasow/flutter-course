import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/details_screen.dart';

class TodoItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      builder: (context, state) {
        List<TodoItem> items = List<TodoItem>();
        if (state is TodoItemsUpdatedState) {
          items.addAll(state.items);
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final TodoItem todoItem = items[index];
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(),
                      ),
                    );

                    // Call edit event
                  },
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      // Call dismiss event
                      final snackBar = SnackBar(
                        content: Text(
                          'Item ${todoItem.title} has been deleted!',
                        ),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Call undo event
                          },
                        ),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: ListTile(
                      title: Text(todoItem.title),
                      subtitle: Text(todoItem.details),
                      leading: Checkbox(
                        onChanged: (value) {
                          // Call mark completed event
                        },
                        value: todoItem.isCompleted ?? false,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
