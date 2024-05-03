import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env["THE_MOVIE_DB_KEY"] ?? "No hay API KEY de The Movie DB";
}
