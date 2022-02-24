import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo_filter/filter_bloc.dart';
import '../todo_list/todo_list_bloc.dart';
import '../todo_search/todo_search_bloc.dart';

import '../../models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final List<Todo> initialList;

  final TodoFilterBloc filter;
  final TodoSearchBloc searchTerm;
  final TodoListBloc list;

  StreamSubscription<TodoFilterState>? filterSubscription;
  StreamSubscription<TodoSearchState>? searchSubscription;
  StreamSubscription<TodoListState>? todosSubscription;

  FilteredTodosBloc({
    required this.initialList,
    required this.filter,
    required this.searchTerm,
    required this.list,
  }) : super(FilteredTodosState(filteredTodos: initialList)) {
    filterSubscription = filter.stream.listen((filter) {
      setFilteredTodos();
    });
    searchSubscription = searchTerm.stream.listen((seargh) {
      setFilteredTodos();
    });
    todosSubscription = list.stream.listen((todos) {
      setFilteredTodos();
    });

    on<NewFilteredTodosEvent>(_filteredTodos);
  }

  void _filteredTodos(
    NewFilteredTodosEvent event,
    Emitter<FilteredTodosState> emit,
  ) {
    emit(state.copyWith(filteredTodos: event.filteredTodos));
  }

  void setFilteredTodos() {
    List<Todo> _filteredList;

    switch (filter.state.filter) {
      case Filter.active:
        _filteredList =
            list.state.todos.where((Todo todo) => !todo.complete).toList();
        break;
      case Filter.complete:
        _filteredList =
            list.state.todos.where((Todo todo) => todo.complete).toList();
        break;
      case Filter.all:
      default:
        _filteredList = list.state.todos;
    }

    if (searchTerm.state.search.isNotEmpty) {
      _filteredList = _filteredList
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.state.search))
          .toList();
    }

    add(NewFilteredTodosEvent(filteredTodos: _filteredList));
  }

  @override
  Future<void> close() {
    filterSubscription?.cancel();
    searchSubscription?.cancel();
    todosSubscription?.cancel();
    return super.close();
  }
}
