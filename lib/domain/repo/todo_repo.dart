import 'package:fluttertruefalse/domain/domain/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> fetchTodos();

  Future<void> toogleTodo(int id);
}
