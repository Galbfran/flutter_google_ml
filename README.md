# google_ml_kit_test_app

Plantilla Flutter orientada a **reconocimiento de texto on-device** con **Google ML Kit**, sobre una base **por features** con **BLoC**, **GoRouter** y **Dio**. Incluye además un **ejemplo de API** (posts) para mostrar red y capas de datos.

## Qué hace la app

- **Splash y home:** flujo inicial y pantalla principal con accesos a las demás secciones.
- **Reconocimiento de texto:** elegís una imagen (vía `image_picker`), el repositorio combina la fuente de imagen con **ML Kit Text Recognition** y se muestra el texto detectado.
- **Ejemplo (`/example`):** listado/demo contra una API REST usando **Dio** y el patrón repositorio; sirve como referencia de red y BLoC, no como producto final.
- **Permisos (debug):** pantalla para inspeccionar el estado de permisos durante el desarrollo.

Las dependencias concretas se cablean en [`lib/app_bootstrap.dart`](lib/app_bootstrap.dart) (`MultiBlocProvider`, `DioClient`, repositorios de posts y de reconocimiento de texto).

## Rutas (GoRouter)

| Ruta | Uso |
|------|-----|
| `/splash` | Pantalla inicial |
| `/home` | Inicio / navegación |
| `/text-recognition` | OCR con ML Kit |
| `/example` | Demo de API + BLoC |
| `/permissions-debug` | Depuración de permisos |

Definidas en [`lib/core/router/app_routes.dart`](lib/core/router/app_routes.dart).

## Requisitos

- **Flutter:** SDK Dart `^3.11.4` (ver [`pubspec.yaml`](pubspec.yaml)).
- **Android:** `minSdk` 26, `compileSdk` 36, `targetSdk` 35 (ver [`android/app/build.gradle.kts`](android/app/build.gradle.kts)).
- **iOS:** 15.5+ (ver [`ios/Podfile`](ios/Podfile)).
- **Herramientas:** Xcode con simuladores o dispositivo Apple para iOS; Android Studio / SDK para Android.

Comprobación rápida:

```bash
flutter doctor
```

## Cómo ejecutar

En la raíz del proyecto:

```bash
flutter pub get
flutter run
```

Tras cambios en dependencias iOS nativas:

```bash
cd ios && pod install && cd ..
```

Elegí dispositivo o simulador con `flutter devices` o el selector del IDE.

## Limitaciones importantes (sobre todo iOS + ML Kit)

- **Simulador iOS 26+ con Xcode 26 en Mac Apple Silicon:** los frameworks nativos que arrastra `google_mlkit_text_recognition` (p. ej. `GoogleMLKit`, `MLImage`, `MLKitCommon`, `MLKitVision`) pueden **no incluir la variante de simulador arm64** que exige ese runtime. En ese caso el build falla con un error de arquitectura. **No es un fallo de tu código:** depende de los pods de Google hasta que publiquen soporte adecuado.
- **Workarounds habituales:** probar en **iPhone físico**, o usar **Xcode 16.x** con un runtime de simulador **anterior a iOS 26** si tu entorno lo permite.
- **Simulador en general:** la cámara es limitada; para OCR suele usarse **galería** o **dispositivo real**.

Para desarrollo estable de OCR en iOS, se recomienda **dispositivo físico**.

## Estructura de `lib/`

Árbol resumido:

```text
lib/
├── main.dart                 # Punto de entrada
├── app_bootstrap.dart        # Composición: providers, router, repos
├── app.dart                  # MaterialApp.router
├── core/
│   ├── bloc/                 # BLoC globales
│   ├── config/               # p. ej. URL base de API
│   ├── media/                # Abstracción + impl de image_picker
│   ├── network/              # Dio, interceptors
│   ├── permissions/          # Servicio de permisos
│   └── router/               # GoRouter, rutas
└── features/
    ├── splash/
    ├── home/
    ├── text_recognition/     # BLoC, UI, datasources ML, repo
    ├── example/              # Demo API (posts)
    └── permissions/          # UI debug de permisos
```

Convención por feature: suele haber `presentation/`, `bloc/`, `data/` (datasources, repositories, DTOs) y `model/` según el caso.

## Dependencias principales

| Paquete | Rol |
|---------|-----|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) + [`equatable`](https://pub.dev/packages/equatable) | Estado y eventos/estados comparables |
| [`go_router`](https://pub.dev/packages/go_router) | Navegación declarativa |
| [`dio`](https://pub.dev/packages/dio) + [`logger`](https://pub.dev/packages/logger) | Cliente HTTP y logs |
| [`provider`](https://pub.dev/packages/provider) | Utilidad en el árbol de widgets (p. ej. junto a BLoC) |
| [`image_picker`](https://pub.dev/packages/image_picker) | Selección de imagen para OCR |
| [`permission_handler`](https://pub.dev/packages/permission_handler) | Permisos de cámara / fotos según plataforma |
| [`google_mlkit_text_recognition`](https://pub.dev/packages/google_mlkit_text_recognition) | Reconocimiento de texto on-device |

Se usa el plugin **concreto** de texto; no el meta-paquete `google_ml_kit`, para acotar dependencias nativas.

## Recursos Flutter

- [Documentación Flutter](https://docs.flutter.dev/)
- [Primeros pasos](https://docs.flutter.dev/get-started/codelab)
