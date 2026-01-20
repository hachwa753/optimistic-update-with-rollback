import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertruefalse/data/repo/todo_repo_impl.dart';
import 'package:fluttertruefalse/domain/dataservice/dataservice.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_bloc.dart';
import 'package:fluttertruefalse/presentation/blocs/todo_event.dart';
import 'package:fluttertruefalse/presentation/pages/home_page.dart';

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  TodoBloc(TodoRepoImpl(Dataservice()))..add(TodoFetchEvent()),
        ),
      ],
      child: HomePage(),
    );
  }
}
