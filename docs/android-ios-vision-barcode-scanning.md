# Escaneo de códigos de barras — Android e iOS

## Para qué sirve y cómo implementarlo

Esta API localiza y decodifica **códigos de barras 1D/2D** (incluido **QR**) en una imagen estática o en fotogramas de la cámara. Es la base de apps de **logística**, **pagos con QR**, **entradas a eventos**, **menús**, **autenticación** (OTP en QR), **inventario** o **trazabilidad** sin depender de un backend para la lectura.

**Implementación sugerida:**

1. Capturar `CameraImage` o `InputImage` desde cámara o galería (plugin `camera` / `image_picker`).
2. Pasar el frame al detector del plugin `google_mlkit_barcode_scanning` con el **formato** de códigos que te interesa (reducir trabajo si solo usás QR).
3. En tiempo real, limitar resolución o FPS para no saturar CPU/GPU.
4. Tras un escaneo exitoso, **cerrar el detector** o pausar la cámara si ya no hace falta (ahorro de batería).

En producción, añadí **solo** `google_mlkit_barcode_scanning` en el `pubspec`, no el paraguas `google_ml_kit`.

## Modelos y requisitos

ML Kit usa un **modelo de detección/decodificación de códigos** gestionado por la librería nativa.

| Aspecto | Detalle |
|--------|---------|
| **Android** | Suele ofrecerse variante **incluida en la app (bundled)** o vía **Google Play Services (unbundled)**. La empaquetada aumenta el tamaño del APK pero evita esperar la primera descarga; la de Play reduce APK y puede descargar el modelo en la primera ejecución o tras instalar desde Play (según manifest / ModuleInstall). |
| **iOS** | El modelo va con el binario del SDK de ML Kit / CocoaPods; no gestionás un `.tflite` suelto desde Flutter. |
| **Red** | Con modelo ya en dispositivo, **no hace falta red** para leer el código. La descarga inicial (si elegís unbundled en Android) sí puede requerir conexión. |

Consulta la página del paquete y [ML Kit — installation paths](https://developers.google.com/ml-kit/tips/installation-paths) para la opción bundled vs unbundled en tu versión de Gradle nativa (el plugin Flutter a veces fija una de las dos).
