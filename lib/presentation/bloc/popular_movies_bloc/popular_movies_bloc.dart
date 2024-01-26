import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<PopularMovies>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (moviesData) {
          emit(PopularMovieHasData(moviesData));
          if (moviesData.isEmpty) {
            emit(PopularMovieEmpty());
          }
        },
      );
    });
  }
}
