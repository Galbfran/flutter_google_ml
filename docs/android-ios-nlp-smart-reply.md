# Respuestas inteligentes (Smart Reply) — Android e iOS

## Para qué sirve y cómo implementarlo

Sugiere **respuestas cortas** contextuales para conversaciones de mensajería (estilo “OK”, “Gracias”, “Llego en 5 min”). Pensado para:

- **Teclados** o apps de chat propias.
- **Atención al cliente** con respuestas rápidas.
- Reducir fricción en móvil.

**Implementación sugerida:**

1. Pasar **historial reciente** en el formato que exige el API (mensajes entrantes/salientes según doc).
2. Filtrar sugerencias por **tono** o políticas de tu producto (el modelo puede proponer frases que no querés mostrar).
3. No usar como generador de textos largos: está optimizado para **respuestas breves**.

Plugin: `google_mlkit_smart_reply`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo de sugerencias entrenado para conversación, disponible vía ML Kit. |
| **Android** | **Unbundled** y **bundled** según configuración nativa (mismo patrón tamaño APK vs Play Services). |
| **iOS** | Integrado con dependencias del plugin. |
| **Red** | Uso **on-device** una vez el modelo está disponible; rutas unbundled pueden implicar descarga inicial. |
| **Idioma** | Soporta un conjunto limitado de idiomas; revisá la doc oficial para tu locale. |

No sustituye a un **LLM** genérico: es especializado en **replies** cortos de chat.
