part of 'todo_bloc.dart';

@immutable
abstract class TodoBlocEvent extends Equatable {}

class AddTodoItemEvent extends TodoBlocEvent {
  final TodoItem item;

  AddTodoItemEvent({@required this.item});

  @override
  List<Object> get props => [this.item];
}

class DeleteTodoItemEvent extends TodoBlocEvent {
  final TodoItem item;

  DeleteTodoItemEvent({@required this.item});

  @override
  List<Object> get props => [this.item];
}

class EditTodoItemEvent extends TodoBlocEvent {
  final TodoItem item;
  final TodoItem oldItem;

  EditTodoItemEvent({
    @required this.item,
    @required this.oldItem,
  });

  @override
  List<Object> get props => [this.item, this.oldItem];
}

class DismissTodoItemEvent extends TodoBlocEvent {
  final TodoItem item;

  DismissTodoItemEvent({@required this.item});

  @override
  List<Object> get props => [this.item];
}

class UndoDismissTodoItemEvent extends TodoBlocEvent {
  final TodoItem item;
  final int index;

  UndoDismissTodoItemEvent({@required this.item, @required this.index});

  @override
  List<Object> get props => [this.item, this.index];
}

class MarkItemCompleted extends TodoBlocEvent {
  final TodoItem item;
  final bool isCompleted;
  final int index;

  MarkItemCompleted({@required this.item, this.isCompleted, this.index});

  @override
  List<Object> get props => [this.item, this.isCompleted];
}

class FilterEvent extends TodoBlocEvent {
  final FilterPopupItem status;

  FilterEvent({@required this.status});

  @override
  List<Object> get props => [this.status];
}

class MarkAllItemsCompletedEvent extends TodoBlocEvent {
  @override
  List<Object> get props => [];
}

class MarkAllItemsActiveEvent extends TodoBlocEvent {
  @override
  List<Object> get props => [];
}

class BeginAddOrEditEvent extends TodoBlocEvent {
  final TodoItem item;

  BeginAddOrEditEvent({@required this.item});

  @override
  List<Object> get props => [this.item];
}


class PullToRefreshEvent extends TodoBlocEvent {
   @override
  List<Object> get props => [];
}
