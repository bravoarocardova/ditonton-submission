part of 'popular_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvEmpty extends TopRatedTvState {}

class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> result;

  const TopRatedTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}
