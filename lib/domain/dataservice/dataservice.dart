import 'package:dio/dio.dart';
import 'package:fluttertruefalse/domain/domain/todo.dart';

class Dataservice {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/todos";
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<List<Todo>> fetchTodos() async {
    try {
      final reponse = await Dio().get(baseUrl);
      final List data = reponse.data;
      _todos = data.map((e) => Todo.fromMap(e)).toList();
      return _todos;
    } on DioException catch (e) {
      print(e.message);
      return [];
    }
  }

  Future<void> toggleTodoD(int id) async {
    final index = _todos.indexWhere((e) => e.id == id);
    if (index == -1) return;

    _todos[index] = _todos[index].copyWith(completed: !_todos[index].completed);

    try {
      final response = await Dio().patch(
        "$baseUrl/$id",
        data: {"completed": _todos[index].completed},
      );

      _todos[index] = Todo.fromMap(response.data);
    } on DioException catch (e) {
      print(e.toString());
    }
  }
}
