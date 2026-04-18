# Reconocimiento de tinta digital (Digital Ink) — Android e iOS

## Para qué sirve y cómo implementarlo

Convierte **trazos** (secuencias de puntos con tiempo y presión opcional) en **texto** o **formas** reconocidas. Pensado para:

- **Notas manuscritas** a texto editable.
- **Tableros** educativos o firmas simplificadas.
- Entrada sin teclado en tablets / móviles con lápiz.

**Implementación sugerida:**

1. Capturar **strokes** en un `Ink` o estructura equivalente del plugin (puntos ordenados en tiempo).
2. Especificar **idioma / locale** del reconocedor (afecta qué modelo se usa).
3. Gestionar **descarga de modelos por idioma**: hay muchos idiomas soportados y **no** van todos empaquetados por defecto en la app.

Plugin: `google_mlkit_digital_ink_recognition`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelos** | **Un modelo por idioma** (o conjunto de idiomas) que ML Kit puede **descargar bajo demanda**; la tabla de ML Kit lista “dynamically downloaded” para digital ink por el gran número de lenguas. |
| **Almacenamiento** | Los modelos descargados quedan en **almacenamiento de la app** tras la primera descarga. |
| **Red** | Hace falta **conexión** al menos para **bajar** el modelo de cada idioma que habilites; luego puede usarse offline para ese idioma. |
| **Tamaño de app** | Sin bundlear todos los idiomas, el APK se mantiene razonable; el coste se mueve a descargas y espacio en disco. |

Planificá en UX: botón “Descargar idioma” o precarga en Wi‑Fi antes de usar la función.
