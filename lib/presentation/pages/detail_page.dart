import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_bloc.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_event.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_state.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoBloc>();
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.status == TodoStatus.loaded) {
          final todo = state.todos.firstWhere((e) => e.id == id);

          return Scaffold(
            appBar: AppBar(title: Text(todo.completed ? "True" : "False")),
            body: Column(
              children: [
                ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      todoProvider.add(TodoToggleEvent(id));
                    },
                  ),
                  title: Text(todo.title),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
