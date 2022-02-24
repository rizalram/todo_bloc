import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo_list/todo_list_bloc.dart';

import '../../models/todo_model.dart';

part 'active_todo_event.dart';
part 'active_todo_state.dart';

class ActiveTodoBloc extends Bloc<ActiveTodoEvent, ActiveTodoState> {
  final int initialCount;
  final TodoListBloc todoListBloc;
  StreamSubscription<TodoListState>? listSubscription;

  ActiveTodoBloc({
    required this.initialCount,
    required this.todoListBloc,
  }) : super(ActiveTodoState(activeCount: initialCount)) {
    listSubscription = todoListBloc.stream.listen((TodoListState list) {
      final int currentActiveTodo =
          list.todos.where((Todo todo) => !todo.complete).toList().length;

      add(CountActiveTodoEvent(activeCount: currentActiveTodo));
    });

    on<CountActiveTodoEvent>(_activeTodo);
  }

  void _activeTodo(CountActiveTodoEvent event, Emitter<ActiveTodoState> emit) {
    emit(state.copyWith(activeCount: event.activeCount));
  }

  @override
  Future<void> close() {
    listSubscription?.cancel();
    return super.close();
  }
}
