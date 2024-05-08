import "package:go_router/go_router.dart";
import "package:cinemapedia/presentation/screens/screens.dart";

final appRouter = GoRouter(
  initialLocation: "/home/0",
  routes: [
    GoRoute(
      path: "/home/:page",
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters["page"] ?? "0");
        return HomeScreen(pageIndex: pageIndex);
      },
      // Rutas hijas de la pantalla Home (para poder volver desde la página de movie a la home)
      routes: [
        GoRoute(
          // La página movie tiene un parámetro id (el id de la película)
          path: "movie/:id",
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters["id"] ?? "no-id";
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(
      path: "/",
      redirect: (_, __) => "/home/0",
    ),
  ],
);
