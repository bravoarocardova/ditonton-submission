import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    bloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListTvStatus: mockGetWatchlistTvStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
  });

  final tId = 1;

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
  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailLoading, RecomendationLoading, TvDetailLoaded and RecomendationLoaded when get  Detail Tv and Recommendation Success',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(tvDetailState: RequestState.Loading),
        TvDetailState.initial().copyWith(
          tvRecommendationState: RequestState.Loading,
          tvDetail: testTvDetail,
          tvDetailState: RequestState.Loaded,
          message: '',
        ),
        TvDetailState.initial().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationState: RequestState.Loaded,
          tvRecommendations: tTvs,
          message: '',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailLoading, RecomendationLoading, TvDetailLoaded and RecommendationError when Get TvRecommendations Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(tvDetailState: RequestState.Loading),
        TvDetailState.initial().copyWith(
          tvRecommendationState: RequestState.Loading,
          tvDetail: testTvDetail,
          tvDetailState: RequestState.Loaded,
          message: '',
        ),
        TvDetailState.initial().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvRecommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailError when Get Tv Detail Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(tvDetailState: RequestState.Loading),
        TvDetailState.initial().copyWith(
          tvDetailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTvDetail)),
      expect: () => [
        TvDetailState.initial()
            .copyWith(watchlistMessage: 'Added to Watchlist'),
        TvDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(tId));
      },
    );
  });

  group('RemoveFromWatchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist False when Success RemoveFromWatchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed From Watchlist'));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(
          watchlistMessage: 'Removed From Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(tId));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistTvStatus.execute(tId));
      },
    );
  });
}
