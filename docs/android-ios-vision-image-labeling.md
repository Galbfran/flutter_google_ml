# Etiquetado de imágenes (Image Labeling) — Android e iOS

## Para qué sirve y cómo implementarlo

Asigna **etiquetas** con **puntuación de confianza** a una imagen (objetos, escenas, conceptos genéricos del modelo base de Google). Sirve para:

- **Clasificación rápida** de fotos de usuario (álbumes, moderación ligera).
- **Búsqueda por contenido** aproximado (“fotos con comida”, “playa”).
- **Triggers** en la cámara (cuando la etiqueta supere un umbral).

**Implementación sugerida:**

1. Definir un **umbral mínimo de confianza** para no mostrar ruido.
2. Para dominios muy específicos (por ejemplo tipos de falla industrial), el **modelo por defecto** puede no bastar: valorar **Image Labeling personalizado** con modelo TensorFlow Lite entrenado por vos.
3. Procesar en isolate o limitar frecuencia si es video en vivo.

Plugin: `google_mlkit_image_labeling` (etiquetado estándar o custom según API del paquete).

## Modelos y requisitos

| Modo | Modelo |
|------|--------|
| **Etiquetado estándar** | Modelo de clasificación multietiqueta entrenado por Google, integrado con ML Kit. |
| **Etiquetado personalizado** | Tu archivo **TensorFlow Lite** (`.tflite`) + metadatos; subís el modelo a la app o lo descargás vos. |

| Android | Soporta **unbundled** y **bundled** para el modelo estándar (mismo trade-off tamaño APK vs descarga Play Services). |
| iOS | Modelo empaquetado con las dependencias del SDK. |
| **Red** | Inferencia on-device con modelo ya disponible; rutas unbundled pueden implicar descarga inicial. |

Revisá límites de etiquetas y si tu caso necesita **custom model** en la documentación del plugin.
