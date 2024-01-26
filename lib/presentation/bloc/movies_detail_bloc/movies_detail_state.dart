part of 'movies_detail_bloc.dart';

class MoviesDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final RequestState movieDetailState;
  final RequestState movieRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MoviesDetailState({
    this.movieDetail,
    required this.movieRecommendations,
    required this.movieDetailState,
    required this.movieRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object?> get props => [
        movieDetail,
        movieRecommendations,
        movieDetailState,
        movieDetailState,
        message,
        watchlistMessage,
        isAddedToWatchlist
      ];

  MoviesDetailState copyWith({
    MovieDetail? movieDetail,
    List<Movie>? movieRecommendations,
    RequestState? movieDetailState,
    RequestState? movieRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MoviesDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendationState:
          movieRecommendationState ?? this.movieRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory MoviesDetailState.initial() {
    return const MoviesDetailState(
      movieDetail: null,
      movieRecommendations: [],
      movieDetailState: RequestState.Empty,
      movieRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}
