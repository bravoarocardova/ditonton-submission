import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMovieEmpty()) {
    on<TopRatedMovies>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMovieError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(TopRatedMovieEmpty());
          } else {
            emit(TopRatedMovieHasData(tvData));
          }
        },
      );
    });
  }
}
