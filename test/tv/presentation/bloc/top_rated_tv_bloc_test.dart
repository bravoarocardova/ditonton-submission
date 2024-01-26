import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc bloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    bloc = TopRatedTvBloc(getTopRatedTv: mockGetTopRatedTv);
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

  group('TopRated Tv', () {
    test('Initial state should be empty', () {
      expect(bloc.state, TopRatedTvEmpty());
    });

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [TopRatedTvLoading, TopRatedTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(TopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [TopRatedTvLoading, TopRatedTvHasData[], TopRatedTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(TopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvHasData(<Tv>[]),
        TopRatedTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [TopRatedTvLoading, TopRatedTvError] when get Failure',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(TopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
