import "package:cinemapedia/domain/datasources/local_storage_datasource.dart";
import "package:cinemapedia/domain/entities/movie.dart";
import "package:isar/isar.dart";
import "package:path_provider/path_provider.dart";

//! Implementación del datasource para acceder a la información de la base de datos local
//? Este datasource lleva el nombre de la base de datos (Isar) porque implementa el datasource para esta base de datos en concreto
//? Si en un futuro tuvieramos usáramos otra base de datos (por ejemplo, SQLite), nos crearíamos la implementación del datasource que accediera a dicha base de datos

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  // Método para alternar el estado de favorito de una película
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      // Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  // Método para verificar si una película es favorita
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  // Método para cargar las películas favoritas
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}
