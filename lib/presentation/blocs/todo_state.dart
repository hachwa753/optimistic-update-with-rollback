import 'package:fluttertruefalse/domain/domain/todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

class TodoMsz extends TodoState {
  final String msz;

  TodoMsz(this.msz);
}
