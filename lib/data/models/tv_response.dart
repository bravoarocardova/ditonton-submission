import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TvResponse extends Equatable {
  int page;
  List<TvModel> tvList;
  int totalPages;
  int totalResults;

  TvResponse({
    required this.page,
    required this.tvList,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        page: json["page"],
        tvList:
            List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  List<Object?> get props => [
        page,
        tvList,
        totalPages,
        totalResults,
      ];
}
