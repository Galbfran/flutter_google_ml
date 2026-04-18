# Segmentación tipo selfie — beta — Android e iOS

## Para qué sirve y cómo implementarlo

Genera una **máscara** que separa a la **persona** del **fondo** en escenas tipo selfie o videollamada. Casos:

- **Reemplazo de fondo** (virtual background).
- **Stickers** que respetan el contorno del cuerpo.
- Composición sin chroma key.

**Implementación sugerida:**

1. Alinear la máscara con el tamaño del frame de cámara (escala y espejo frontal).
2. Suavizar bordes en postproceso si la app lo requiere (shader o blur en el borde).
3. No es sustituto de **matting** profesional en todos los fondos; pelo fino y fondos complejos pueden fallar.

Plugin: `google_mlkit_selfie_segmentation`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo de segmentación entrenado para **figura humana** en primer plano; suele ir **bundled** con la librería ML Kit (incluido en la app o descargable según variante nativa). |
| **Plataformas** | Android e iOS en la matriz estándar del ecosistema; ver versión exacta del plugin. |
| **Red** | Uso típico **offline** tras tener el binario/modelo en el dispositivo. |

Para segmentar **objetos arbitrarios** o sujetos no-humanos, esta API no es la herramienta adecuada; mirá **subject segmentation** (Android) u otras soluciones.
