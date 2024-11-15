import 'dart:convert';

class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // Convert from JSON (API response)
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  // Convert to JSON for SharedPreferences storage
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  // Convert from Map (for SharedPreferences)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      id: map['id'] ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: (map['popularity'] ?? 0.0).toDouble(),
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: (map['vote_average'] ?? 0.0).toDouble(),
      voteCount: map['vote_count'] ?? 0,
    );
  }

  // Convert to Map (for SharedPreferences)
  Map<String, dynamic> toMap() {
    return toJson();
  }

  // Helper method to convert Movie to JSON string
  String toJsonString() {
    return json.encode(toJson());
  }

  // Helper method to create Movie from JSON string
  static Movie fromJsonString(String jsonString) {
    return Movie.fromJson(json.decode(jsonString));
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title}';
  }

  // Helper method for deep equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Movie &&
        other.id == id &&
        other.title == title &&
        other.adult == adult &&
        other.backdropPath == backdropPath &&
        other.originalLanguage == originalLanguage &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.video == video &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount &&
        _listEquals(other.genreIds, genreIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode ^
    adult.hashCode ^
    backdropPath.hashCode ^
    originalLanguage.hashCode ^
    originalTitle.hashCode ^
    overview.hashCode ^
    popularity.hashCode ^
    posterPath.hashCode ^
    releaseDate.hashCode ^
    video.hashCode ^
    voteAverage.hashCode ^
    voteCount.hashCode ^
    genreIds.hashCode;
  }

  // Helper method for list comparison
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}