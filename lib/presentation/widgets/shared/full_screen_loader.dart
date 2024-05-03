import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});

  final messages = <String>[
    "Cargando películas...",
    "Comprando palomitas de maíz...",
    "Cargando populares...",
    "Llamando a mi novia...",
    "Ya mero...",
    "Esto está tardando más de lo esperado :(",
    "¿Pero quién ha programado esto?",
    "Estás a 2 segundos de llevarte una estrella...",
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(seconds: 2), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor..."),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Cargando...");
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
