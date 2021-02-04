part of 'todo_bloc.dart';

@immutable
abstract class TodoBlocState extends Equatable {}

class TodoBlocInitial extends TodoBlocState {
  @override
  List<Object> get props => [];
}

class TodoItemsUpdatedState extends TodoBlocState {
  final List<TodoItem> items;

  TodoItemsUpdatedState({@required this.items});
  @override
  List<Object> get props => [this.items];
}

class TodoItemEditState extends TodoBlocState {
  final TodoItem item;

  TodoItemEditState({@required this.item});

  @override
  List<Object> get props => [this.item];
}

class TodoItemDetailsState extends TodoBlocState {
  final TodoItem item;

  TodoItemDetailsState({@required this.item});

  @override
  List<Object> get props => [this.item];
}

class TodoItemAddState extends TodoBlocState {
  @override
  List<Object> get props => [];
}
