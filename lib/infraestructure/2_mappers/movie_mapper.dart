//? El objetivo del mapper es leer diferentes modelos y crear nuestra entidad (MovieMovieDB > Movie)

import 'package:cinemapedia/domain/1_entities/movie.dart';
import 'package:cinemapedia/infraestructure/1_models/moviedb/moviedb_response.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}" : "https://eticketsolutions.com/demo/themes/e-ticket/img/movie.jpg",
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != "" ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}" : "no-poster",
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );
}
