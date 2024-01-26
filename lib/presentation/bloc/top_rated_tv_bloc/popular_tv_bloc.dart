import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_state.dart';
part 'popular_tv_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;
  TopRatedTvBloc({required this.getTopRatedTv}) : super(TopRatedTvEmpty()) {
    on<TopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await getTopRatedTv.execute();

      result.fold(
        (failure) => emit(TopRatedTvError(failure.message)),
        (tvData) {
          if (tvData.isEmpty) {
            emit(TopRatedTvEmpty());
          } else {
            emit(TopRatedTvHasData(tvData));
          }
        },
      );
    });
  }
}
