part of 'popular_movies_bloc.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class TopRatedMovies extends TopRatedMoviesEvent {}
