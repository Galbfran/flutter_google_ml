# Reconocimiento de texto v2 (OCR) — Android e iOS

## Para qué sirve y cómo implementarlo

Extrae **texto estructurado** (bloques, líneas, palabras, símbolos) de imágenes: documentos, carteles, pantallas, etiquetas, tarjetas. Casos típicos:

- **Digitalizar** tickets, facturas o apuntes.
- **Buscar o copiar** texto desde una foto.
- **Accesibilidad** (leer en voz alta lo que ve la cámara).
- **Onboarding** (rellenar datos desde DNI o carnet, con validación humana).

**Implementación sugerida:**

1. Elegir el **script**: latín, chino, japonés, coreano, devanagari (cada uno puede ser un artefacto/modelo distinto en Android).
2. Preprocesar imagen: **enfoque**, recorte, evitar reflejos; el OCR falla con texto muy pequeño o borroso.
3. Usar `google_mlkit_text_recognition` con el recognizer adecuado al script.
4. Para muchos idiomas latinos mezclados, el modelo **Latin** suele bastar; para otros alfabetos hay que **inicializar el recognizer correcto**.

## Modelos y requisitos

Text Recognition v2 usa **modelos por script**, no un único “modelo universal” ligero.

| Script / idioma | Modelo (concepto) |
|-----------------|-------------------|
| Latín | Modelo Latin (~unos MB si va bundled por ABI). |
| Chino, japonés, coreano, devanagari | Cada uno con **dependencia / modelo** asociado en la capa nativa. |

| Android | **Bundled**: el modelo viaja en el APK (más peso, listo offline). **Unbundled (Play Services)**: APK más liviano; el modelo puede bajarse en instalación o primer uso. |
| iOS | Modelos incluidos vía pods de ML Kit; elijas el modo/script según la guía de Apple del plugin. |
| **Red** | Inferencia local; la **primera descarga** del modelo (unbundled) puede requerir Internet. |

Referencia: [Text recognition v2](https://developers.google.com/ml-kit/vision/text-recognition/v2) y [installation paths](https://developers.google.com/ml-kit/tips/installation-paths).
