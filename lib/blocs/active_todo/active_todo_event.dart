part of 'active_todo_bloc.dart';

abstract class ActiveTodoEvent extends Equatable {
  const ActiveTodoEvent();

  @override
  List<Object> get props => [];
}

class CountActiveTodoEvent extends ActiveTodoEvent {
  final int activeCount;

  const CountActiveTodoEvent({
    required this.activeCount,
  });

  @override
  List<Object> get props => [activeCount];
}
