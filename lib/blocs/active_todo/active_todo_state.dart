part of 'active_todo_bloc.dart';

class ActiveTodoState extends Equatable {
  final int activeCount;

  const ActiveTodoState({
    this.activeCount = 0,
  });

  @override
  List<Object> get props => [activeCount];

  ActiveTodoState copyWith({
    int? activeCount,
  }) {
    return ActiveTodoState(
      activeCount: activeCount ?? this.activeCount,
    );
  }
}
