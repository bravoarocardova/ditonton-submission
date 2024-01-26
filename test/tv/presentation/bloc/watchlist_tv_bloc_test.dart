import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvBloc bloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    bloc = WatchlistTvBloc(getWatchlistTv: mockGetWatchlistTv);
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

  group('Watchlist Tv', () {
    test('Initial state should be empty', () {
      expect(bloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvHasData[], WatchlistTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvHasData(<Tv>[]),
        WatchlistTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvError] when get Failure',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(WatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvError('Failed'),
      ],
      verify: (_) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });
}
