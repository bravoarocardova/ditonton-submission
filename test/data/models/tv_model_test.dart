import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [10766],
    id: 206559,
    originCountry: ["ZA"],
    originalLanguage: "af",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 2965.138,
    posterPath: "/path.jpg",
    firstAirDate: DateTime(2024),
    name: "Name",
    voteAverage: 6.37,
    voteCount: 27,
  );

  final tTv = Tv(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [10766],
    id: 206559,
    originCountry: ["ZA"],
    originalLanguage: "af",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 2965.138,
    posterPath: "/path.jpg",
    firstAirDate: DateTime(2024),
    name: "Name",
    voteAverage: 6.37,
    voteCount: 27,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
