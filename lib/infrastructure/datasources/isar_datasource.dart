import "package:cinemapedia/domain/datasources/local_storage_datasource.dart";
import "package:cinemapedia/domain/entities/movie.dart";
import "package:isar/isar.dart";
import "package:path_provider/path_provider.dart";

//! Implementación del datasource para acceder a la información de la base de datos local
//? Este datasource lleva el nombre de la base de datos (Isar) porque implementa el datasource para esta base de datos en concreto
//? Si en un futuro tuvieramos usáramos otra base de datos (por ejemplo, SQLite), nos crearíamos la implementación del datasource que accediera a dicha base de datos

class IsarDatasource extends LocalStorageDatasource {
  // El acceso a base de datos no es una tarea asíncrona, debemos esperar a leer y recibir los datos, por lo que no es necesario que sea un Future, debe ser "late"
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      // Hay que indicar el listado de esquemas a los que queremos acceder. Los esquemas se crean automáticamente cuando ejecutamos flutter pub run build_runner build (Ver Readme)
      return await Isar.open([MovieSchema], inspector: true, directory: dir.path);
    }

    // Si la base de datos ya está abierta, devolvemos la instancia
    return Future.value(Isar.getInstance());
  }

  @override
  // Método para alternar el estado de favorito de una película
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db; // Esperamos a que la base de datos esté lista

    // Buscamos la película por su id (Campo "id": "id" + "EqualTo")
    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    // Si la película es favorita, la borramos, si no, la insertamos
    if (favoriteMovie != null) {
      // Borramos la película (deja de estar en favoritos)
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    } else {
      // Insertamos la película (la añadimos a favoritos)
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }

  @override
  // Método para verificar si una película es favorita
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db; // Esperamos a que la base de datos esté lista

    // Buscamos la película por su id (Campo "id": "id" + "EqualTo")
    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();

    // Si la película es favorita (ha sido encontrada), devolvemos true, si no, false
    return isFavoriteMovie != null;
  }

  @override
  // Método para cargar las películas favoritas
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db; // Esperamos a que la base de datos esté lista

    // Devolvemos las películas favoritas, saltando las primeras "offset" y limitando a "limit"
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}
