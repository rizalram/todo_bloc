import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(const TodoSearchState()) {
    on<SearchTodoEvent>(
      _searchTodo,
      transformer: sequential(),
    );
  }

  void _searchTodo(SearchTodoEvent event, Emitter<TodoSearchState> emit) {
    emit(state.copyWith(search: event.search));
  }
}
