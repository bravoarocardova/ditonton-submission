part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMovieLoading extends PopularMoviesState {}

class PopularMovieEmpty extends PopularMoviesState {}

class PopularMovieHasData extends PopularMoviesState {
  final List<Movie> result;

  const PopularMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class PopularMovieError extends PopularMoviesState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
