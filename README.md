# cinemapedia

# Dev

1. Copiar el .env.template y renombrarlo a .env

2. Cambiar las variables de entorno (The MovieDB)

3. Cambios en la entidad, hay que ejecutar el comando

```
flutter pub run build_runner build
```

## Base de datos Isar

### Instalación y configuración

1. Instalar las dependencias "isar" y "isar_flutter_libs":

> flutter pub add isar isar_flutter_libs

2. Instalar las dependencias de desarrollo "isar_generator" y "build_runner":

> flutter pub add -d isar_generator build_runner

Todas las dependencias de Isar ("isar", "isar_flutter_libs", "isar_generator") deben tener la misma versión.

https://pub.dev/packages/isar
https://pub.dev/packages/isar_flutter_libs
https://pub.dev/packages/isar_generator

3. Añadir la anotación "@collection"

[]["relacion_isar.png"];



