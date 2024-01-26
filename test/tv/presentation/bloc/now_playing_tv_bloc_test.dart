import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_bloc/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvBloc bloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    bloc = NowPlayingTvBloc(getNowPlayingTv: mockGetNowPlayingTv);
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

  group('NowPlaying Tv', () {
    test('Initial state should be empty', () {
      expect(bloc.state, NowPlayingTvEmpty());
    });

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      expect: () => [
        NowPlayingTvLoading(),
        NowPlayingTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvHasData[], NowPlayingTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      expect: () => [
        NowPlayingTvLoading(),
        const NowPlayingTvHasData(<Tv>[]),
        NowPlayingTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvError] when get Failure',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      expect: () => [
        NowPlayingTvLoading(),
        const NowPlayingTvError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });
}
