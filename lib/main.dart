import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';

Future<void> main() async {
  //? Cargamos las variables de entorno (necesario el paquete flutter_dotenv)
  await dotenv.load(fileName: ".env");

  //? Configuramos el provider Riverpod
  //runApp(const MainApp());
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      //? No hay home porque GoRouter ya sabe cual es la pantalla inicial
      //home: const Scaffold(
      //  body: Center(
      //    child: Text('Hello World!'),
      //  ),
      //),
    );
  }
}
