part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterUpdateState extends CounterState {
  final int count;
  CounterUpdateState({this.count});
}
