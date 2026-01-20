import 'package:fluttertruefalse/domain/dataservice/dataservice.dart';
import 'package:fluttertruefalse/domain/domain/todo.dart';
import 'package:fluttertruefalse/domain/repo/todo_repo.dart';

class TodoRepoImpl implements TodoRepo {
  final Dataservice service;
  TodoRepoImpl(this.service);

  @override
  Future<List<Todo>> fetchTodos() async {
    return service.fetchTodos();
  }

  @override
  Future<void> toogleTodo(int id) async {
    return await service.toggleTodoD(id);
  }
}
