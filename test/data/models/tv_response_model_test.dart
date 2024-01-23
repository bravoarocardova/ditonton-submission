import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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
    firstAirDate: DateTime(2005, 10, 13),
    name: "Name",
    voteAverage: 6.37,
    voteCount: 27,
  );

  final tTvResponseModel = TvResponse(
      page: 1, tvList: <TvModel>[tTvModel], totalPages: 54, totalResults: 1077);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "page": 1,
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [10766],
            "id": 206559,
            "origin_country": ["ZA"],
            "original_language": "af",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 2965.138,
            "poster_path": "/path.jpg",
            "first_air_date": "2005-10-13",
            "name": "Name",
            "vote_average": 6.37,
            "vote_count": 27
          }
        ],
        "total_pages": 54,
        "total_results": 1077
      };
      expect(result, expectedJsonMap);
    });
  });
}
