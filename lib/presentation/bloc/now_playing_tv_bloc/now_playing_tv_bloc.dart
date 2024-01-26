import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_state.dart';
part 'now_playing_tv_event.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv getNowPlayingTv;
  NowPlayingTvBloc({required this.getNowPlayingTv})
      : super(NowPlayingTvEmpty()) {
    on<NowPlayingTv>((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await getNowPlayingTv.execute();

      result.fold(
        (failure) => emit(NowPlayingTvError(failure.message)),
        (tvData) {
          emit(NowPlayingTvHasData(tvData));
          if (tvData.isEmpty) {
            emit(NowPlayingTvEmpty());
          }
        },
      );
    });
  }
}
