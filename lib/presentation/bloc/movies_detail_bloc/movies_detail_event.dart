part of 'movies_detail_bloc.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesDetail extends MoviesDetailEvent {
  final int id;

  const FetchMoviesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends MoviesDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends MoviesDetailEvent {
  final MovieDetail movieDetail;

  const AddToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlist extends MoviesDetailEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
