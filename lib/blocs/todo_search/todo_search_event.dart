part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTodoEvent extends TodoSearchEvent {
  final String search;

  const SearchTodoEvent({
    required this.search,
  });

  @override
  List<Object> get props => [search];
}
