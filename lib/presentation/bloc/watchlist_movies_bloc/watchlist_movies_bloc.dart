import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_state.dart';
part 'watchlist_movies_event.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMoviesBloc({required this.getWatchlistMovies})
      : super(WatchlistMovieEmpty()) {
    on<WatchlistMovies>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(WatchlistMovieEmpty());
          } else {
            emit(WatchlistMovieHasData(moviesData));
          }
        },
      );
    });
  }
}
