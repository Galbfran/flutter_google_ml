# Segmentación de sujeto — beta — solo Android

## Para qué sirve y cómo implementarlo

Enfocado en separar el **sujeto principal** de la escena (no limitado al encuadre “selfie”). Útil para:

- **Recortes** automáticos del elemento destacado.
- Efectos donde el fondo completo debe cambiar manteniendo al sujeto.
- Preparación de imágenes para diseño o redes.

**Implementación sugerida:**

1. Revisar **matriz Android vs iOS**: en muchas versiones la API está **solo en Android** o con soporte asimétrico.
2. Probar en escenas con un solo sujeto claro; multitud o sujetos pequeños pueden confundir el modelo.

Plugin: `google_mlkit_subject_segmentation`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo de segmentación semántica/instance del “sujeto” principal, distribuido con ML Kit (detalles exactos en la guía nativa del API). |
| **Plataforma** | Confirmar en pub.dev: **iOS a menudo no soportado** según la tabla del proyecto. |
| **Red / bundled** | Sigue el patrón del resto de Vision: uso on-device; tamaño y descarga dependen de si el plugin usa variante bundled o vía Play Services en Android. |

Si tu app es **multiplataforma**, tené un **fallback** en iOS (otra UI o otra técnica).
