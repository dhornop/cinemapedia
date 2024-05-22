# Cinemapedia

App desarrollada durante el curso de Flutter de Fernando Herrera

# <span style="color: yellow">Desarrollo</span>

1. Copiar el .env.template y renombrarlo a .env

2. Cambiar las variables de entorno (The MovieDB)

3. Cambios en la entidad, hay que ejecutar el comando:

    > flutter pub run build_runner build

# <span style="color: yellow">Base de datos Isar</span>

## Instalación y configuración

1. Instalar las dependencias <span style="color: green">__isar__</span>, <span style="color: green">__isar_flutter_libs__</span> y <span style="color: green">__path_provider__</span>:

    > flutter pub add isar isar_flutter_libs path_provider

2. Instalar las dependencias de desarrollo <span style="color: green">__isar_generator__</span> y <span style="color: green">__build_runner__</span>:

    > flutter pub add -d isar_generator build_runner

    Todas las dependencias de Isar (<span style="color: green">isar</span>, <span style="color: green">isar_flutter_libs</span> e <span style="color: green">isar_generator</span>) deben tener la misma versión.

    https://pub.dev/packages/isar
    
    https://pub.dev/packages/isar_flutter_libs
    
    https://pub.dev/packages/isar_generator

3. Añadir la anotación <span style="color: green">__@collection__</span>: Asocia la clase de la entidad con la clase de base de datos.

    ![](documentacion/readme/relacion_isar.png "Relación clases")

4. Añadir el identificador único para la base de datos:

    ```
    Id? isarId;
    ```

5. Añadir el part con la nomenclatura <span style="color: green">__nombreClase.g.dart__</span>. Varios ejemplos:

    > Movie > part "movie.g.dart"

    > Cliente > part "cliente.g.dart"

    > Factura > part "factura.g.dart"

    Al añadirlo, se mostrará un error, es normal.

6. Ejecutar el comando generador de base de datos:

    > flutter pub run build_runner build

Estructura de ejemplo:

    - domain
        - datasources
            - local_storage_datasource.dart
        - repositories
            - local_storage_repository.dart
    - infrastructure
        - datasources
            - isar_datasource.dart                  (1)
        - repositories
            - local_storage_repository_impl.dart    (2)
    - presentation
        - providers > storage
            - local_storage_provider.dart           (Provider genérico con los métodos definidos que une 1 con 2)
            - favorite_movies_provider.dart         (Provider para el listado de películas favoritas)

        + screens > movies
            + movie_screen.dart                     (Botón "Marcar favorito" > Buscar "Botón para añadir/quitar de favoritos")

        + views > movies
            + favorites_view.dart                   (Listado de películas favoritas)

Al ejecutar la aplicación desde Visual Studio Code e instanciar por primera vez la base de datos, en la ventana de "Consola de depuración" se nos mostrará un enlace para poder visualizar la base de datos.

# <span style="color: yellow">Tipos diferentes de Providers (Riverpod)</span>

Hay múltiples tipos de providers para diferentes casos de uso.

Con todos estos providers disponibles, a veces es difícil entender cuándo utilizar un tipo de provider sobre otro. Utiliza la tabla a continuación para elegir un provider que se adapte a lo que deseas proporcionar al árbol de widgets.

| Tipo de Provider | Función de creación de Provider | Ejemplo de caso de uso |
| -- | -- | -- |
| [Provider](https://riverpod.dev/es/docs/providers/provider) | Retorna cualquier tipo | Una clase de servicio / propiedad calculada (lista filtrada) |
| [StateProvider](https://riverpod.dev/es/docs/providers/state_provider) | Retorna cualquier tipo | Una condición de filtro / objeto de estado simple |
| [FutureProvider](https://riverpod.dev/es/docs/providers/future_provider) | Retorna un Future de cualquier tipo | Un resultado de una llamada a una API |
| [StreamProvider](https://pub.dev/documentation/riverpod/latest/riverpod/StreamProvider-class.html) | Retorna un Stream de cualquier tipo | Un stream de los resultados de una API |
| [StateNotifierProvider](https://riverpod.dev/es/docs/providers/state_notifier_provider) | Retorna una subclase de StateNotifier | Un objeto de estado complejo que es inmutable excepto a través de una interfaz |



