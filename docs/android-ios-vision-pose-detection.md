# Detección de pose corporal — beta — Android e iOS

## Para qué sirve y cómo implementarlo

Detecta **puntos clave del cuerpo** (hombros, codos, rodillas, etc.) en 2D y, según modo, información 3D. Sirve para:

- Apps de **fitness**, **yoga**, **rehabilitación** (feedback de postura).
- **Juegos** controlados por el cuerpo.
- Efectos visuales que siguen la silueta.

**Implementación sugerida:**

1. Elegir modo **“fast” vs accurate** (más precisión = más coste).
2. Cuerpo completo visible mejora mucho la estabilidad; oclusión fuerte degrada keypoints.
3. Procesar a resolución razonable; la pose en Full HD a 60 FPS puede ser pesada en gama baja.

Plugin: `google_mlkit_pose_detection` (y variante “accurate” si aplica en tu versión).

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelos** | Modelos de estimación de pose **incluidos (bundled)** con el cliente de ML Kit para esta API (según tabla oficial de installation paths). |
| **Beta** | API en evolución; revisá cambios entre versiones del plugin. |
| **Android / iOS** | Ambos suelen estar soportados en la matriz Flutter; confirmá en pub.dev. |
| **Red** | Inferencia local; sin descarga extra si el modelo va bundled con la app. |

Diferente de **segmentación**: la pose devuelve **articulaciones**, no una máscara pixel a pixel del cuerpo.
