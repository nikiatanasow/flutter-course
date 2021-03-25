import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/details_screen.dart';

class TodoItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      buildWhen: (previous, current) =>
          current.items != previous.items ||
          current.isLoading != previous.isLoading,
      builder: (context, state) {
        final List<TodoItem> items = []..addAll(state.items);

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async =>
                  await BlocProvider.of<TodoBloc>(context).pullToRefresh(),
              child: ListView.builder(
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

                          BlocProvider.of<TodoBloc>(context)
                              .beginEdit(todoItem);
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            BlocProvider.of<TodoBloc>(context)
                                .dismissItem(todoItem);
                            final snackBar = SnackBar(
                              content: Text(
                                'Item ${todoItem.title} has been deleted!',
                              ),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () =>
                                    BlocProvider.of<TodoBloc>(context)
                                        .undoDissmissItem(todoItem),
                              ),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: ListTile(
                            title: Text(todoItem.title),
                            subtitle: Text(todoItem.details),
                            leading: Checkbox(
                              onChanged: (value) =>
                                  BlocProvider.of<TodoBloc>(context)
                                      .markCompleted(todoItem, value),
                              value: todoItem.isCompleted ?? false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
        );
      },
    );
  }
}
