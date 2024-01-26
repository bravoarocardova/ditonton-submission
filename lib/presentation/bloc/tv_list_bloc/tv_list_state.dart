part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class TvListInitialState extends TvListState {}

class TvStateLoading extends TvListState {}

class TvStateEmpty extends TvListState {}

class TvStateHasData extends TvListState {
  final List<Tv> result;

  const TvStateHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvStateError extends TvListState {
  final String message;

  const TvStateError(this.message);

  @override
  List<Object> get props => [message];
}
