# Resumen de texto (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

Produce un **resumen** más corto de un texto de entrada (nota larga, artículo pegado, transcripción). Sirve para:

- **Vista previa** en listados.
- **TL;DR** antes de leer completo.
- Reducir tokens si luego enviás el resumen a otro sistema (con cuidado de pérdida de información).

**Implementación sugerida:**

1. Establecer **longitud objetivo** o tipo de resumen si la API lo permite.
2. Advertir que pueden perderse **matices o datos numéricos**; para contratos o médico, no confiar ciegamente.
3. Para textos enormes, **partir en chunks** si el modelo tiene límite de contexto.

Plugin: `google_mlkit_genai_summarization`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo generativo de **compresión semántica** del stack GenAI local. |
| **Red** | Descarga inicial del modelo probable al activar la función. |
| **Memoria** | Textos largos + modelo generativo pueden acercarse a límites de RAM en dispositivos viejos. |
| **Calidad** | Menor que resúmenes cloud de gran modelo; suficiente para muchos casos de productividad. |

Si necesitás **extractivo** (solo frases del original) frente a **abstractivo** (nuevo texto), confirmá qué hace exactamente la API en tu versión del plugin.
