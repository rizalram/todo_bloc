import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<FilteredTodosBloc>().state.filteredTodos;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todo[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoEvent(todo: todo[index]));
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Delet'),
                    ),
                  ],
                );
              },
            );
          },
          child: BuildItem(
            todo: todo[index],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: todo.length,
    );
  }

  Widget showBackground(int direction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.redAccent,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}

class BuildItem extends StatefulWidget {
  const BuildItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  _BuildItemState createState() => _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(
        value: widget.todo.complete,
        onChanged: (_) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(
        widget.todo.desc,
        style: TextStyle(
          color: widget.todo.complete ? Colors.grey : Colors.black,
          decoration: widget.todo.complete ? TextDecoration.lineThrough : null,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            controller.text = widget.todo.desc;
            bool erroText = false;

            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit'),
                  content: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      errorText: erroText ? 'Tidak boleh kosong' : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          erroText = controller.text.isEmpty ? true : false;
                          if (!erroText) {
                            context.read<TodoListBloc>().add(EditTodoEvent(
                                  id: widget.todo.id,
                                  desc: controller.text,
                                ));
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
