# Escáner de documentos — beta — solo Android

## Para qué sirve y cómo implementarlo

Flujo pensado para **capturar documentos** (hojas, formularios): detecta bordes, corrige **perspectiva** y genera una imagen tipo “escaneo” más legible que una foto casual. Casos:

- **Digitalización** de facturas, contratos o formularios.
- **Archivo** de papel con calidad uniforme.
- Paso previo a **OCR** para mejorar la tasa de acierto del texto.

**Implementación sugerida:**

1. Comprobar si tu versión del plugin es **solo Android** (común en la documentación del ecosistema).
2. Guiar al usuario con overlay de bordes y feedback cuando el documento no está bien encuadrado.
3. Tras el escaneo, opcionalmente pasar la imagen a **Text Recognition v2**.

Plugin: `google_mlkit_document_scanner`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Pipeline** | Combina detección de documento, geometría y postprocesado; no es un único `.tflite` que cargues manualmente, sino el **SDK Document Scanner** de ML Kit. |
| **Plataforma** | Suele estar **restringido a Android** en la tabla oficial; **no asumas iOS** hasta leer el README del paquete. |
| **Red** | El procesamiento principal es **on-device**; permisos de cámara y almacenamiento según flujo. |
| **Beta** | Cambios de API o disponibilidad entre versiones. |

Para iOS, valorá **VisionKit** nativo de Apple o un flujo de cámara + recorte manual si el plugin no cubre la plataforma.
