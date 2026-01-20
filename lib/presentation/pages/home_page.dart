import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_bloc.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_event.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_state.dart';
import 'package:fluttertruefalse/presentation/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoBloc>();
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return Center(child: Text("api not loaded"));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      todoProvider.add(TodoToggleEvent(todo.id));
                    },
                  ),
                  title: Text(todo.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BlocProvider.value(
                              value: todoProvider,
                              child: DetailPage(id: todo.id),
                            ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
