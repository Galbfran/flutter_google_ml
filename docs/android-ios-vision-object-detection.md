# Detección y seguimiento de objetos — Android e iOS

## Para qué sirve y cómo implementarlo

Detecta **objetos** conocidos por el modelo base (con categoría y caja) y, en secuencias de video, puede **mantener un seguimiento** entre frames. Casos de uso:

- **Conteo aproximado** o avisos cuando aparece cierta categoría.
- **Juegos** o apps educativas con la cámara.
- **Prototipos** de “ver qué hay en la escena” sin servidor.

**Implementación sugerida:**

1. Ajustar expectativas: el modelo **generalista** no reconoce marcas ni objetos arbitrarios finos.
2. Para **clases propias** (por ejemplo defectos en una pieza), usar el flujo de **detección con modelo personalizado** (TFLite) si el plugin lo expone.
3. En video, usar el modo **stream** si está disponible para aprovechar el tracking.

Plugin: `google_mlkit_object_detection`.

## Modelos y requisitos

| Modo | Modelo |
|------|--------|
| **Detección estándar** | Modelo de detección de objetos incluido en ML Kit (bundled típicamente). |
| **Custom** | Modelo **TensorFlow Lite** compatible con la API de detección de ML Kit. |

| Android | Modelo **bundled** suele aumentar el tamaño de la app pero evita esperar descargas. |
| iOS | Incluido en los pods de ML Kit Vision. |
| **Red** | Inferencia local una vez el binario/modelo está en el dispositivo. |

La **precisión** depende de iluminación, tamaño del objeto en imagen y si la categoría existe en el vocabulario del modelo base.
