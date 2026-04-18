# Malla facial (Face Mesh) — beta — solo Android

## Para qué sirve y cómo implementarlo

Estima una **malla densa de vértices 3D** sobre la superficie del rostro (mucho más puntos que la detección clásica). Sirve para:

- **AR** y maquillaje virtual muy ajustado al contorno.
- **Animación** o avatares que copian expresión.
- Análisis fino de **expresión** o alineación facial.

**Implementación sugerida:**

1. Asegurar buena **iluminación** y rostro suficientemente grande en el frame.
2. Usar cámara frontal estable; la malla es sensible a oclusión (manos, pelo).
3. Comprobar en la documentación actual del plugin **soporte por plataforma** (históricamente **Android sí, iOS limitado o no** según versión).

Plugin: `google_mlkit_face_mesh_detection`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo de malla facial en 3D incluido en el pipeline de ML Kit para esta API (beta). |
| **Distribución** | En la matriz oficial de ML Kit, **Face Mesh** suele ir como **bundled** (incluido en el binario del cliente), no como traducción con 300+ descargas. |
| **Android / iOS** | Ver tabla del paquete en pub.dev: la disponibilidad **iOS** puede ser **no** o beta; no asumas paridad. |
| **Rendimiento** | Más costoso que `FaceDetector` clásico; conviene resolución moderada y no máximo FPS. |

Antes de producto, validá dispositivos objetivo y la nota **beta** de la API.
