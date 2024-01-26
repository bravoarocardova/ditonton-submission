part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieLoading extends WatchlistMoviesState {}

class WatchlistMovieEmpty extends WatchlistMoviesState {}

class WatchlistMovieHasData extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieError extends WatchlistMoviesState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
