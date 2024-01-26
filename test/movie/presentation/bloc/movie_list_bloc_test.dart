import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late NowPlayingMoviesListBloc nowPlayingMovieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late PopularMoviesListBloc popularMovieListBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late TopRatedMoviesListBloc topRatedMovieListBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieListBloc = NowPlayingMoviesListBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieListBloc = PopularMoviesListBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieListBloc = TopRatedMoviesListBloc(mockGetTopRatedMovies);
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

  group('now playing movie list', () {
    test('Initial state should be empty', () {
      expect(nowPlayingMovieListBloc.state, MovieListInitialState());
    });

    blocTest<NowPlayingMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        MovieStateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateError] when get Failure',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        const MovieStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('popular movie list', () {
    test('Initial state should be empty', () {
      expect(popularMovieListBloc.state, MovieListInitialState());
    });

    blocTest<PopularMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        MovieStateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateError] when get Failure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        const MovieStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('top rated movie list', () {
    test('Initial state should be empty', () {
      expect(topRatedMovieListBloc.state, MovieListInitialState());
    });

    blocTest<TopRatedMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        MovieStateHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMoviesListBloc, MovieListState>(
      'Should emit [MovieStateLoading, MovieStateError] when get Failure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(MoviesList()),
      expect: () => [
        MovieStateLoading(),
        const MovieStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
