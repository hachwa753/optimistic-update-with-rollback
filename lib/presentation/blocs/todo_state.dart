// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fluttertruefalse/domain/domain/todo.dart';

// enum wise and equatable and props meaning

enum TodoStatus { initial, loading, loaded, error }

class TodoState extends Equatable {
  final TodoStatus status;
  final List<Todo> todos;
  final String msz;
  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const [],
    this.msz = "",
  });

  TodoState copyWith({TodoStatus? status, List<Todo>? todos, String? msz}) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      msz: msz ?? this.msz,
    );
  }

  @override
  List<Object?> get props => [status, todos, msz];
}
