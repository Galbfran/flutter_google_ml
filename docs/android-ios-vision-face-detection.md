# Detección de rostros — Android e iOS

## Para qué sirve y cómo implementarlo

Detecta **rostros** en imagen o video y devuelve **cajas delimitadoras**, **landmarks** (ojos, nariz, boca, etc.) y **clasificadores opcionales** (ojos abiertos, sonrisa). Sirve para:

- **Filtros y stickers** que siguen la cara.
- **Verificación de presencia** (“hay alguien mirando la cámara”).
- **Recorte automático** para foto de perfil.
- **Preproceso** antes de otra API (por ejemplo malla facial o efectos).

**Implementación sugerida:**

1. Convertir el frame de cámara a `InputImage` con la **rotación** correcta (clave para que las cajas coincidan con la vista previa).
2. Configurar el `FaceDetector` con el modo **performance vs accuracy** y activar solo los **landmarks/clasificadores** que necesites (menos trabajo = menos batería).
3. En video, no procesar todos los frames si no hace falta (cada 2–3 frames).
4. Liberar el detector en `dispose`.

Plugin recomendado: `google_mlkit_face_detection`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Red neuronal de detección facial de ML Kit (ligera vs precisa según opción del API). |
| **Android** | Soporta **bundled** y **unbundled** (Play Services); bundled = mayor tamaño de app, disponible offline al instante; unbundled = APK más liviano, posible descarga en primer uso. |
| **iOS** | Modelo integrado con las dependencias CocoaPods del plugin. |
| **Red** | Inferencia **on-device**; la descarga del modelo (solo en rutas unbundled/dinámicas) puede usar red una vez. |

No confundir con **reconocimiento de identidad** (quién es la persona): esta API solo detecta **que hay una cara** y su geometría aproximada.
