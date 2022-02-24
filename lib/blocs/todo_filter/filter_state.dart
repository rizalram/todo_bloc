part of 'filter_bloc.dart';

enum Filter {
  all,
  active,
  complete,
}

class TodoFilterState extends Equatable {
  final Filter filter;

  const TodoFilterState({
    this.filter = Filter.all,
  });

  @override
  List<Object> get props => [filter];

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}
