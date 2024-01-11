import 'package:json_annotation/json_annotation.dart';
part 'ttnflix_movies.g.dart';


@JsonSerializable(createToJson: false)
class TtnflixMoviesModel{
  final int? page;
  @JsonKey(name: "results")
  final List<Movie>? movieList;
  @JsonKey(name: "total_pages")
  final int? totalPages;
  @JsonKey(name: "total_results")
  final int? totalResults;

  const TtnflixMoviesModel(
      this.page, this.movieList, this.totalPages, this.totalResults);

  factory TtnflixMoviesModel.fromJson(Map<String, dynamic> data) =>
      _$TtnflixMoviesModelFromJson(data);
}

@JsonSerializable(createToJson: false)
class Movie {
  final String? title;
  final String? overview;
  final bool? adult;
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;

  const Movie(this.title, this.overview, this.adult, this.originalLanguage, this.backdropPath);

  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  String getContentRating() {
    return adult! ? "A" : "U/A";
  }
}
