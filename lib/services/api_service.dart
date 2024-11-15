import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/movie_model.dart';
import '../util/constants.dart';
import 'logger.dart';

class MovieApiService {
  final Dio _dio = Dio();

  final String _baseUrl = baseUrl;
  final String _apiKey = apiKey;

  MovieApiService() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'api_key': _apiKey},
      );

      return (response.data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch movies');
    }
  }
}