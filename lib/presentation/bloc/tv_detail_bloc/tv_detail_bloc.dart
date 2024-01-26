import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(TvDetailState.initial()) {
    on<FetchTvDetail>((event, emit) async {
      emit(state.copyWith(tvDetailState: RequestState.Loading));
      final detailResult = await getTvDetail.execute(event.id);
      final recommendationResult = await getTvRecommendations.execute(event.id);

      detailResult.fold(
        (failure) => emit(state.copyWith(
          tvDetailState: RequestState.Error,
          message: failure.message,
        )),
        (tvsData) {
          emit(state.copyWith(
              tvDetailState: RequestState.Loaded,
              tvDetail: tvsData,
              tvRecommendationState: RequestState.Loading,
              message: ''));

          recommendationResult.fold(
            (failure) => emit(
              state.copyWith(
                tvRecommendationState: RequestState.Error,
                message: failure.message,
              ),
            ),
            (recomendation) => emit(
              state.copyWith(
                tvRecommendationState: RequestState.Loaded,
                tvRecommendations: recomendation,
                message: '',
              ),
            ),
          );
        },
      );
    });
    on<AddToWatchlist>((event, emit) async {
      final result = await saveWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvDetail.id));
    });
    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlistTv.execute(event.tvDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatus(event.tvDetail.id));
    });
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListTvStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
