import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertruefalse/domain/repo/todo_repo.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_event.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo repo;
  TodoBloc(this.repo) : super(TodoInitial()) {
    on<TodoFetchEvent>(_fetchTodo);
    on<TodoToggleEvent>(_toggleTodoEvent);
  }

  void _fetchTodo(TodoFetchEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await repo.fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoMsz(e.toString()));
    }
  }

  void _toggleTodoEvent(TodoToggleEvent event, Emitter<TodoState> emit) async {
    if (state is! TodoLoaded) return;

    final currentTodos = (state as TodoLoaded).todos;
    //toggle locally
    final updatedTodos =
        currentTodos.map((e) {
          if (e.id == event.id) {
            return e.copyWith(completed: !e.completed);
          }
          return e;
        }).toList();
    emit(TodoLoaded(updatedTodos));

    try {
      await repo.toogleTodo(event.id);
    } catch (e) {
      emit(TodoLoaded(currentTodos));
      emit(TodoMsz(e.toString()));
    }
  }
}
