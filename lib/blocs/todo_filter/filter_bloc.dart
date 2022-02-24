import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(const TodoFilterState()) {
    on<ChangeFilterEvent>(_changeFilter);
  }

  void _changeFilter(ChangeFilterEvent event, Emitter<TodoFilterState> emit) {
    emit(state.copyWith(filter: event.filter));
  }
}
