part of 'todo_bloc.dart';

@immutable
class TodoBlocState extends Equatable {
  final List<TodoItem> items;
  final TodoItem currentItem;
  final bool isLoading;

  TodoBlocState({this.items, this.currentItem, this.isLoading});

  TodoBlocState copyWith(
      {List<TodoItem> items, TodoItem currentItem, bool isLoading}) {
    return TodoBlocState(
      items: items ?? this.items,
      currentItem: currentItem ?? this.currentItem,
      isLoading: isLoading ?? false,
    );
  }

  @override
  List<Object> get props => [this.items, this.currentItem, this.isLoading];
}
