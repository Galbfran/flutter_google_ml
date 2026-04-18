# Reescritura de texto (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

**Reformula** un texto manteniendo el sentido (más formal, más corto, más simple, etc.) según las **opciones** que exponga la API del plugin. Útil para:

- Adaptar el mismo mensaje a **distintos públicos**.
- Simplificar textos largos para móvil.
- Tonos “amigable / profesional” con un toque.

**Implementación sugerida:**

1. Ofrecer **presets** claros en la UI (“Más corto”, “Más formal”).
2. Guardar siempre el **texto original**.
3. Validar que no se pierdan **datos críticos** (números, fechas) al reescribir.

Plugin: `google_mlkit_genai_rewriting`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo generativo de reescritura del módulo GenAI; tamaño y calidad acotados al dispositivo. |
| **Red** | Posible descarga del peso del modelo al habilitar la función por primera vez. |
| **Límites** | Longitud máxima de entrada/salida según versión; probá con tus casos reales. |
| **Sesgo** | El modelo puede cambiar matices; revisión humana en contenido sensible. |

Complementa, no reemplaza, a **traducción** (Translation) si lo que necesitás es otro idioma, no otro tono.
