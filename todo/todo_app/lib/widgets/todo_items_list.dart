import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/screens/details_screen.dart';

class TodoItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(
      buildWhen: (previous, current) => current is TodoItemsUpdatedState,
      builder: (context, state) {
        List<TodoItem> items = List<TodoItem>();
        if (state is TodoItemsUpdatedState) {
          items.addAll(state.items);
        }

        // TODO: Nasko to fix
         Future<void> _getData() async {
            BlocProvider.of<TodoBloc>(context).add(PullToRefreshEvent());
          }

        return RefreshIndicator(
          onRefresh: _getData,
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
                          .add(BeginAddOrEditEvent(item: todoItem));
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        BlocProvider.of<TodoBloc>(context)
                            .add(DismissTodoItemEvent(item: todoItem));
                        final snackBar = SnackBar(
                          content: Text(
                            'Item ${todoItem.title} has been deleted!',
                          ),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              BlocProvider.of<TodoBloc>(context).add(
                                  UndoDismissTodoItemEvent(
                                      item: todoItem, index: index));
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
                            BlocProvider.of<TodoBloc>(context).add(
                              MarkItemCompleted(
                                  item: todoItem,
                                  isCompleted: value,
                                  index: index),
                            );
                          },
                          value: todoItem.isCompleted ?? false,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
