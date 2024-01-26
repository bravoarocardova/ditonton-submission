import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_state.dart';
part 'movie_list_event.dart';

class NowPlayingMoviesListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesListBloc(this.getNowPlayingMovies)
      : super(MovieListInitialState()) {
    on<MoviesList>((event, emit) async {
      emit(MovieStateLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(MovieStateError(failure.message)),
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(MovieStateEmpty());
          } else {
            emit(MovieStateHasData(moviesData));
          }
        },
      );
    });
  }
}

class PopularMoviesListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesListBloc(this.getPopularMovies)
      : super(MovieListInitialState()) {
    on<MoviesList>((event, emit) async {
      emit(MovieStateLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(MovieStateError(failure.message)),
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(MovieStateEmpty());
          } else {
            emit(MovieStateHasData(moviesData));
          }
        },
      );
    });
  }
}

class TopRatedMoviesListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesListBloc(this.getTopRatedMovies)
      : super(MovieListInitialState()) {
    on<MoviesList>((event, emit) async {
      emit(MovieStateLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(MovieStateError(failure.message)),
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(MovieStateEmpty());
          } else {
            emit(MovieStateHasData(moviesData));
          }
        },
      );
    });
  }
}
