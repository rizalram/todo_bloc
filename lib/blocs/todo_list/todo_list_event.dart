part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String desc;

  const AddTodoEvent({
    required this.desc,
  });

  @override
  List<Object> get props => [desc];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String desc;

  const EditTodoEvent({
    required this.id,
    required this.desc,
  });

  @override
  List<Object> get props => [id, desc];
}

class ToggleTodoEvent extends TodoListEvent {
  final String id;

  const ToggleTodoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;

  const RemoveTodoEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
