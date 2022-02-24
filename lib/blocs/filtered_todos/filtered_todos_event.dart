part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class NewFilteredTodosEvent extends FilteredTodosEvent {
  final List<Todo> filteredTodos;

  const NewFilteredTodosEvent({
    required this.filteredTodos,
  });

  @override
  List<Object> get props => [filteredTodos];
}
