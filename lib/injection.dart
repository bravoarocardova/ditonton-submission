import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_detail_bloc/movies_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_bloc/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() async {
  // bloc
  locator.registerFactory(
    () => NowPlayingMoviesListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvListBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListTvStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvBloc(
      getNowPlayingTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      getTopRatedTv: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  http.Client client = await getSSLPinningClient();
  locator.registerLazySingleton(() => client);
}
