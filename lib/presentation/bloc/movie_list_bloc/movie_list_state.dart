part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListInitialState extends MovieListState {}

class MovieStateLoading extends MovieListState {}

class MovieStateEmpty extends MovieListState {}

class MovieStateHasData extends MovieListState {
  final List<Movie> result;

  const MovieStateHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieStateError extends MovieListState {
  final String message;

  const MovieStateError(this.message);

  @override
  List<Object> get props => [message];
}
