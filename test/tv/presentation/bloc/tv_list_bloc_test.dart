import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc/tv_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late NowPlayingTvListBloc nowPlayingTvListBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late PopularTvListBloc popularTvListBloc;
  late MockGetPopularTv mockGetPopularTv;
  late TopRatedTvListBloc topRatedTvListBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;
  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvListBloc = NowPlayingTvListBloc(mockGetNowPlayingTv);
    mockGetPopularTv = MockGetPopularTv();
    popularTvListBloc = PopularTvListBloc(mockGetPopularTv);
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvListBloc = TopRatedTvListBloc(mockGetTopRatedTv);
  });

  final tTv = Tv(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: DateTime.parse('2005-10-23'),
    genreIds: [1],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 3.0,
    posterPath: 'posterPath',
    voteAverage: 2.0,
    voteCount: 12,
  );
  final tTvList = <Tv>[tTv];

  group('now playing tv list', () {
    test('Initial state should be empty', () {
      expect(nowPlayingTvListBloc.state, TvListInitialState());
    });

    blocTest<NowPlayingTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        TvStateHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateError] when get Failure',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return nowPlayingTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        const TvStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });

  group('popular tv list', () {
    test('Initial state should be empty', () {
      expect(popularTvListBloc.state, TvListInitialState());
    });

    blocTest<PopularTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        TvStateHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateError] when get Failure',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        const TvStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTv.execute());
      },
    );
  });

  group('top rated tv list', () {
    test('Initial state should be empty', () {
      expect(topRatedTvListBloc.state, TvListInitialState());
    });

    blocTest<TopRatedTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateHasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        TvStateHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvListBloc, TvListState>(
      'Should emit [TvStateLoading, TvStateError] when get Failure',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(TvListE()),
      expect: () => [
        TvStateLoading(),
        const TvStateError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
