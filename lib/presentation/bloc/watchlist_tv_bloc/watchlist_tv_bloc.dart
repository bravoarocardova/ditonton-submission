import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_state.dart';
part 'watchlist_tv_event.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;
  WatchlistTvBloc({required this.getWatchlistTv}) : super(WatchlistTvEmpty()) {
    on<WatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchlistTv.execute();

      result.fold(
        (failure) => emit(WatchlistTvError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(WatchlistTvEmpty());
          } else {
            emit(WatchlistTvHasData(tvData));
          }
        },
      );
    });
  }
}
