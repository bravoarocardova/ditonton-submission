import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTv = Tv(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: [1],
  id: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 2.0,
  posterPath: 'posterPath',
  firstAirDate: DateTime.parse("2022-01-01"),
  name: 'name',
  voteAverage: 4.0,
  voteCount: 30,
);

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 1,
      creditId: 'creditId',
      name: 'name',
      gender: 1,
      profilePath: 'profilePath',
    )
  ],
  episodeRunTime: [],
  firstAirDate: DateTime.parse('2005-10-23'),
  genres: [Genre(id: 1, name: 'name')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  languages: [],
  lastAirDate: DateTime.parse('2005-10-23'),
  lastEpisodeToAir: LastEpisodeToAir(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 3.0,
    voteCount: 222,
    airDate: DateTime.parse('2005-10-23'),
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 60,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  ),
  name: 'name',
  nextEpisodeToAir: 'nextEpisodeToAir',
  networks: [
    Network(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry')
  ],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 3.0,
  posterPath: 'posterPath',
  productionCompanies: [
    Network(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry')
  ],
  productionCountries: [ProductionCountry(iso31661: 'iso31661', name: 'name')],
  seasons: [
    Season(
        airDate: DateTime.parse('2005-10-23'),
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1.0)
  ],
  spokenLanguages: [
    SpokenLanguage(englishName: 'englishName', iso6391: 'iso6391', name: 'name')
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 2.0,
  voteCount: 12,
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvList = [testTv];
