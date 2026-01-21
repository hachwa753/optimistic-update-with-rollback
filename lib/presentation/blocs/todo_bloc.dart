import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertruefalse/domain/domain/todo.dart';
import 'package:fluttertruefalse/domain/repo/todo_repo.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_event.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo repo;
  TodoBloc(this.repo) : super(TodoState()) {
    on<TodoFetchEvent>(_fetchTodo);
    on<TodoToggleEvent>(_toggleTodoEvent);
  }

  void _fetchTodo(TodoFetchEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    try {
      final todos = await repo.fetchTodos();
      emit(state.copyWith(status: TodoStatus.loaded, todos: todos));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, msz: e.toString()));
    }
  }

  void _toggleTodoEvent(TodoToggleEvent event, Emitter<TodoState> emit) async {
    if (state.status != TodoStatus.loaded) return;

    final currentTodos = List<Todo>.from(state.todos);

    //ui updates immediately
    final updatedTodos =
        state.todos.map((e) {
          if (e.id == event.id) {
            return e.copyWith(completed: !e.completed);
          }
          return e;
        }).toList();

    emit(state.copyWith(todos: updatedTodos));

    // Update API in background
    try {
      await repo.toogleTodo(event.id);
    } catch (e) {
      emit(
        state.copyWith(
          todos: currentTodos,
          status: TodoStatus.error,
          msz: "Toggle failed, reverted",
        ),
      );
    }
  }
}


// void _toggleTodoEvent(TodoToggleEvent event, Emitter<TodoState> emit) async {
//     if (state is! TodoLoaded) return;

//     final currentTodos = (state as TodoLoaded).todos;
//     //toggle locally
//     final updatedTodos =
//         currentTodos.map((e) {
//           if (e.id == event.id) {
//             return e.copyWith(completed: !e.completed);
//           }
//           return e;
//         }).toList();
//     emit(TodoLoaded(updatedTodos));

//     try {
//       await repo.toogleTodo(event.id);
//     } catch (e) {
//       emit(TodoLoaded(currentTodos));
//       emit(TodoMsz(e.toString()));
//     }
//   }

// emit(TodoLoading());
//     try {
//       final todos = await repo.fetchTodos();
//       emit(TodoLoaded(todos));
//     } catch (e) {
//       emit(TodoMsz(e.toString()));
//     }