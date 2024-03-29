part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvLoading extends PopularTvState {}

class PopularTvEmpty extends PopularTvState {}

class PopularTvHasData extends PopularTvState {
  final List<Tv> result;

  const PopularTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTvError extends PopularTvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}
