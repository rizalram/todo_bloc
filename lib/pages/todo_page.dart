import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/pages/search_and_filter.dart';
import 'package:todo_bloc/pages/show_todos.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  "Todos",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 24),
                const _CreateTodo(),
                const SizedBox(height: 16),
                const SearchAndFilter(),
                const SizedBox(height: 16),
                const ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateTodo extends StatefulWidget {
  const _CreateTodo({Key? key}) : super(key: key);

  @override
  __CreateTodoState createState() => __CreateTodoState();
}

class __CreateTodoState extends State<_CreateTodo> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Create Todo'),
      onSubmitted: (String? desc) {
        if (desc != null && desc.trim().isNotEmpty) {
          context.read<TodoListBloc>().add(AddTodoEvent(desc: desc));
          controller.clear();
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
