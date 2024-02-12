import 'package:json_annotation/json_annotation.dart';
part 'ttnflix_movies.g.dart';

@JsonSerializable(createToJson: false)
class TtnflixMoviesModel {
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
  @JsonKey(includeFromJson: false)
  bool isFavourite = false;
  String? title;
  int? id;
  String? overview;
  bool? adult;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "release_date")
  String? releaseDate;
  @JsonKey(name: "media_type")
  String? mediaType;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  Movie(
      this.title,
      this.overview,
      this.adult,
      this.originalLanguage,
      this.backdropPath,
      this.posterPath,
      this.releaseDate,
      this.voteAverage,
      this.mediaType,
      this.id,
      this.voteCount);

  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  String getContentRating() {
    return adult! ? "A" : "U/A";
  }

  Movie.fromMap(Map<String, Object?> map) {
    isFavourite = true;
    backdropPath = map['imageUrl'] as String;
    posterPath = map['posterPath'] as String?;
    mediaType = map['mediaType'] as String;
    adult = map['adult'] == 1;
    id = map['id'] as int;
    title = map['title'] as String;
    overview = map['overview'] as String;
    mediaType = map['mediaType'] as String;
    releaseDate = map['releaseDate'] as String;
    voteAverage = (map['voteAverage'] as num?)?.toDouble();
    voteCount = map['voteCount'] as int;
    originalLanguage = map['language'] as String;
  }

  Map<String, Object?> toMap(Movie instance) => <String, Object?>{
        'imageUrl': instance.backdropPath,
        'posterPath': instance.posterPath,
        'mediaType': instance.mediaType,
        'adult': (instance.adult == true) ? 1 : 0,
        'id': instance.id,
        'title': instance.title,
        'overview': instance.overview,
        'releaseDate': instance.releaseDate,
        'voteCount': instance.voteCount,
        'voteAverage': instance.voteAverage,
        'language': instance.originalLanguage
      };
}
