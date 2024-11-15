import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/movie_model.dart';
import '../repository/movie_repository.dart';

abstract class MovieEvent {}
class LoadMovies extends MovieEvent {}

abstract class MovieState {}
class MovieInitial extends MovieState {}
class MovieLoading extends MovieState {}
class MovieLoaded extends MovieState {
  final List<Movie> movies;
  MovieLoaded(this.movies);
}
class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc({required this.repository}) : super(MovieInitial()) {
    on<LoadMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await repository.getMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}