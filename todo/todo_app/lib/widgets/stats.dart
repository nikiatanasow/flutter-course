import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_item.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoBlocState>(builder: (context, state) {
      List<TodoItem> items = List<TodoItem>();
      if (state is TodoItemsUpdatedState) {
        items.addAll(state.items);
      }
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Completed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              items
                  .where((element) => element.isCompleted == true)
                  .length
                  .toString(),
            ),
            Text(
              'Active',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              items
                  .where((element) =>
                      element.isCompleted == false ||
                      element.isCompleted == null)
                  .length
                  .toString(),
            ),
          ],
        ),
      );
    });
  }
}
