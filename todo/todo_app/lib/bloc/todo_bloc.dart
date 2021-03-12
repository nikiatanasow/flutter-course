import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/bloc/todo_repository.dart';
import 'package:todo_app/models/filter_popup_item.dart';
import 'package:todo_app/models/todo_item.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  TodoRepository repository;
  // TodoBloc({@required this.repository}) : super(TodoBlocInitial());
  TodoBloc() : super(TodoBlocInitial()) {
    repository = TodoRepository(
        (items) => {this.emit(TodoItemsUpdatedState(items: items))});
  }

  @override
  Stream<TodoBlocState> mapEventToState(
    TodoBlocEvent event,
  ) async* {
    if (event is AddTodoItemEvent) {
      await repository.provider.addItem(item: event.item);
      final items = await repository.provider.items;
      yield TodoItemsUpdatedState(items: items);
    }

    if (event is DeleteTodoItemEvent) {
      await repository.provider.removeItem(item: event.item);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }

    if (event is BeginAddOrEditEvent) {
      yield TodoItemEditState(item: event.item);
    }

    if (event is EditTodoItemEvent) {
      await repository.provider.updateItem(event.item, event.oldItem);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
      yield TodoItemEditState(item: event.item);
    }

    if (event is DismissTodoItemEvent) {
      await repository.dismiss(event.item);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }

    if (event is UndoDismissTodoItemEvent) {
      repository.undoDismiss(event.item, event.index);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }

    if (event is MarkItemCompleted) {
      await repository.markItemCompleted(
          event.item, event.isCompleted, event.index);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }

    if (event is FilterEvent) {
      final items = repository.filter(event.status);

      yield TodoItemsUpdatedState(items: items);
    }

    if (event is MarkAllItemsCompletedEvent) {
      await repository.mark(true);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }

    if (event is MarkAllItemsActiveEvent) {
      await repository.mark(false);

      yield TodoItemsUpdatedState(items: await repository.provider.items);
    }
  }
}
