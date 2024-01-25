// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ttnflix_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TtnflixMoviesModel _$TtnflixMoviesModelFromJson(Map<String, dynamic> json) =>
    TtnflixMoviesModel(
      json['page'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total_pages'] as int?,
      json['total_results'] as int?,
    );

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['title'] as String?,
      json['overview'] as String?,
      json['adult'] as bool?,
      json['original_language'] as String?,
      json['backdrop_path'] as String?,
      json['poster_path'] as String?,
      json['release_date'] as String?,
      (json['vote_average'] as num?)?.toDouble(),
      json['media_type'] as String?,
      json['id'] as int?,
      json['vote_count'] as int?,
    );
