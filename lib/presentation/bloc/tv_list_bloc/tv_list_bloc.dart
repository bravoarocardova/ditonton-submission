import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_list_state.dart';
part 'tv_list_event.dart';

class NowPlayingTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvListBloc(this.getNowPlayingTv) : super(TvListInitialState()) {
    on<TvListE>((event, emit) async {
      emit(TvStateLoading());
      final result = await getNowPlayingTv.execute();

      result.fold(
        (failure) => emit(TvStateError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(TvStateEmpty());
          } else {
            emit(TvStateHasData(tvData));
          }
        },
      );
    });
  }
}

class PopularTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetPopularTv getPopularTv;

  PopularTvListBloc(this.getPopularTv) : super(TvListInitialState()) {
    on<TvListE>((event, emit) async {
      emit(TvStateLoading());
      final result = await getPopularTv.execute();

      result.fold(
        (failure) => emit(TvStateError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(TvStateEmpty());
          } else {
            emit(TvStateHasData(tvData));
          }
        },
      );
    });
  }
}

class TopRatedTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvListBloc(this.getTopRatedTv) : super(TvListInitialState()) {
    on<TvListE>((event, emit) async {
      emit(TvStateLoading());
      final result = await getTopRatedTv.execute();

      result.fold(
        (failure) => emit(TvStateError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(TvStateEmpty());
          } else {
            emit(TvStateHasData(tvData));
          }
        },
      );
    });
  }
}
