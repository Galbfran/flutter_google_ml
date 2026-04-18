# Corrección / revisión de texto (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

Propone **correcciones** u **mejoras** sobre un texto (gramática, estilo, claridad) usando el modelo GenAI local. Pensado para:

- Editores de notas, email o formularios largos.
- Segunda pasada antes de enviar un mensaje profesional.

**Implementación sugerida:**

1. Enviar **solo el fragmento necesario** para no exceder límites del modelo.
2. Presentar cambios como **diff** o sugerencias aceptables una a una.
3. Permitir **deshacer** si el usuario prefiere el original.

Plugin: `google_mlkit_genai_proofreading`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo generativo enfocado en **revisión textual** incluido en el paquete GenAI correspondiente. |
| **Idioma** | Confirmá idiomas soportados en la documentación del plugin; puede estar optimizado para inglés u otros. |
| **Red** | Descarga inicial del modelo posible; inferencia local después. |
| **Privacidad** | Ventaja frente a enviar borradores a un servidor; revisá políticas de datos de Google para el SDK. |

No sustituye a un **revisor humano** en textos legales o médicos.
