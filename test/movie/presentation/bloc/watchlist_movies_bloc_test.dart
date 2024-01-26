import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMoviesBloc bloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMoviesBloc(getWatchlistMovies: mockGetWatchlistMovies);
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

  group('Watchlist Movies', () {
    test('Initial state should be empty', () {
      expect(bloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [WatchlistMovieLoading, WatchlistMovieHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistMovies()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [WatchlistMovieLoading, WatchlistMovieHasData[], WatchlistMovieEmpty] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right(<Movie>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistMovies()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieHasData(<Movie>[]),
        WatchlistMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [WatchlistMovieLoading, WatchlistMoviesError] when get Failure',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistMovies()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieError('Failed'),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
