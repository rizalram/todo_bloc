part of 'filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends TodoFilterEvent {
  final Filter filter;

  const ChangeFilterEvent({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];
}
