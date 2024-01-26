import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('Popular Movies', () {
    test('Initial state should be empty', () {
      expect(bloc.state, PopularMovieEmpty());
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [PopularMovieLoading, PopularMovieHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularMovies()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [PopularMovieLoading, PopularMovieHasData[], PopularMovieEmpty] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Right(<Movie>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularMovies()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieHasData(<Movie>[]),
        PopularMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [PopularMovieLoading, PopularMoviesError] when get Failure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularMovies()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
