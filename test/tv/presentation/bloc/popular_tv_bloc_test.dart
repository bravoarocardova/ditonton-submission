import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc bloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    bloc = PopularTvBloc(mockGetPopularTv);
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

  group('Popular Tv', () {
    test('Initial state should be empty', () {
      expect(bloc.state, PopularTvEmpty());
    });

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [PopularTvLoading, PopularTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularTv()),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [PopularTvLoading, PopularTvHasData[], PopularTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularTv()),
      expect: () => [
        PopularTvLoading(),
        const PopularTvHasData(<Tv>[]),
        PopularTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [PopularTvLoading, PopularTvError] when get Failure',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(PopularTv()),
      expect: () => [
        PopularTvLoading(),
        const PopularTvError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
