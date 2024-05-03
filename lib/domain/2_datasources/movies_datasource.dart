import 'package:cinemapedia/domain/1_entities/movie.dart';

//?Abstracta porque no queremos crear instancias de ella

abstract class MoviesDatasource {
  //Devuelve las películas que hay actualmente en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1});

  //Devuelve las películas más populares
  Future<List<Movie>> getPopular({int page = 1});

  //Devuelve las películas que llegarán próximamente
  Future<List<Movie>> getUpcoming({int page = 1});

  //Devuelve las películas mejor valoradas
  Future<List<Movie>> getTopRated({int page = 1});
}
