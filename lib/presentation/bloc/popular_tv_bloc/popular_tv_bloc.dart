import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_state.dart';
part 'popular_tv_event.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;
  PopularTvBloc(this.getPopularTv) : super(PopularTvEmpty()) {
    on<PopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final result = await getPopularTv.execute();

      result.fold(
        (failure) => emit(PopularTvError(failure.message)),
        (tvData) {
          emit(PopularTvHasData(tvData));
          if (tvData.isEmpty) {
            emit(PopularTvEmpty());
          }
        },
      );
    });
  }
}
