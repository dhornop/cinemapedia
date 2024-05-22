import "package:cinemapedia/domain/repositories/local_storage_repository.dart";
import "package:cinemapedia/presentation/providers/providers.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:cinemapedia/domain/entities/movie.dart";

//! Provider exclusivo para el listado películas favoritas

/*
  {
    1234: Movie,
    1645: Movie,
    6523: Movie,
  }
*/

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  // Método para cargar las películas favoritas
  Future<List<Movie>> loadNextPage() async {
    // Obtenemos las películas favoritas de la base de datos local de la página actual
    // page = 0 -> offset = 0, limit = 20
    // page = 1 -> offset = 10, limit = 20
    // page = 2 -> offset = 20, limit = 20
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    // Agregamos las películas a un mapa temporal
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    // Emitimos un nuevo estado con las películas favoritas
    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
