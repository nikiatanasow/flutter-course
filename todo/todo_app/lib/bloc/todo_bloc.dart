import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/bloc/todo_repository.dart';
import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';

part 'todo_bloc_state.dart';

class TodoBloc extends Cubit<TodoBlocState> {
  TodoRepository repository;
  TodoBloc()
      : super(
          TodoBlocState(
            items: [],
            isLoading: true,
          ),
        ) {
    repository = TodoRepository(
      (items) => {
        this.emit(state.copyWith(items: items)),
      },
    );
  }

  Future<void> addItem(TodoItem item) async {
    await _executeFunction(function: repository.provider.addItem(item: item));
  }

  Future<void> deleteItem(TodoItem item) async {
    this.state.items.remove(item);
    await _executeFunction(
        function: repository.provider.removeItem(item: item));
  }

  Future<void> editItem(TodoItem item) async {
    emit(state.copyWith(isLoading: true));
    await repository.provider.updateItem(item);

    final items = await repository.provider.fetchItems();
    emit(state.copyWith(items: items, currentItem: item));
  }

  Future<void> dismissItem(TodoItem item) async {
    this.state.items.remove(item);
    await _executeFunction(function: repository.dismiss(item));
  }

  Future<void> undoDissmissItem(TodoItem item) async {
    await _executeFunction(function: repository.undoDismiss(item));
  }

  Future<void> markCompleted(TodoItem item, bool isCompleted) async {
    await _executeFunction(
        function: repository.markItemCompleted(item, isCompleted));
  }

  Future<void> markItems(bool isCompleted) async {
    await _executeFunction(function: repository.mark(isCompleted));
  }

  Future<void> filter(FilterPopupItem status) async {
    emit(state.copyWith(isLoading: true));
    final List<TodoItem> items = await repository.filter(status);
    emit(state.copyWith(items: items));
  }

  Future<void> pullToRefresh() async {
    final List<TodoItem> items = await repository.provider.fetchItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _executeFunction({Future function}) async {
    emit(state.copyWith(isLoading: true));
    if (function != null) {
      await function;
    }

    final List<TodoItem> items = await repository.provider.fetchItems();
    emit(state.copyWith(items: items));
  }
}
