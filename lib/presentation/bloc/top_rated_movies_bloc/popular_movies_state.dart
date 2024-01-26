part of 'popular_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieLoading extends TopRatedMoviesState {}

class TopRatedMovieEmpty extends TopRatedMoviesState {}

class TopRatedMovieHasData extends TopRatedMoviesState {
  final List<Movie> result;

  const TopRatedMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMovieError extends TopRatedMoviesState {
  final String message;

  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}
