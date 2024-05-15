import "package:cinemapedia/presentation/providers/providers.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:cinemapedia/domain/entities/movie.dart";

/*
  {
    "505642": Movie(),
    "505643": Movie(),
    "505645": Movie(),
    "501231": Movie(),
  }
*/

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

//! Cacheo de películas ya vistas

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);

    //Clonamos el estado anterior añadiendo el nuevo MovieId
    state = {...state, movieId: movie};
  }
}
