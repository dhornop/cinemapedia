import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/1_entities/movie.dart';
import 'package:cinemapedia/domain/2_datasources/movies_datasource.dart';
import 'package:cinemapedia/infraestructure/1_models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infraestructure/2_mappers/movie_mapper.dart';
import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource {
  //Indicamos la url base del API REST
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.theMovieDbKey,
        "language": "es-ES",
      },
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    //Transformamos la respuesta al modelo de MovieDb
    final movieDbResponse = MovieDbResponse.fromJson(json);

    //TODO: Si llegamos al final, la aplicación se bloquea. Revisar

    //Transformamos el modelo de MovieDb a una lista de nuestra entidad "movie"
    //Omitimos todas las películas que no tengan imagen del poster
    final List<Movie> movies = movieDbResponse.results.where((moviedb) => moviedb.posterPath != "no-poster").map((moviedb) => MovieMapper.movieDbToEntity(moviedb)).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //Obtenemos las películas que están actualmente en cines
    final response = await dio.get(
      "/movie/now_playing",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    //Obtenemos las películas más populares
    final response = await dio.get(
      "/movie/popular",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    //Obtenemos las películas mejor valoradas
    final response = await dio.get(
      "/movie/top_rated",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    //Obtenemos las películas que llegarán próximamente
    final response = await dio.get(
      "/movie/upcoming",
      queryParameters: {
        "page": page,
      },
    );

    return _jsonToMovies(response.data);
  }
}
