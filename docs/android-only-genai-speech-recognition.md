# Reconocimiento de voz (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

Convierte **audio de voz** en **texto** usando el pipeline que expone el plugin GenAI de ML Kit (puede diferir del reconocimiento “clásico” del sistema operativo). Casos:

- **Dictado** en apps propias con política de datos on-device.
- Comandos o notas de voz transcritas antes de enviarlas a un backend.

**Implementación sugerida:**

1. Gestionar **permisos de micrófono** y feedback de silencio/ruido.
2. Definir si usás **streaming** o grabación completa antes de reconocer (según API).
3. Comparar con **`speech_to_text`** u otros: la ventaja aquí es la **integración ML Kit / modelo embebido** si aplica a tu política.

Plugin: `google_mlkit_genai_speech_recognition`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo **ASR** (automatic speech recognition) empaquetado o descargable con el módulo GenAI; idiomas y calidad según doc del paquete. |
| **Red** | Algunos modos pueden exigir descarga del modelo; uso offline posible tras tenerlo. |
| **Hardware** | Audio en tiempo real consume CPU; probá en gama baja. |
| **Privacidad** | Audio procesado según implementación del SDK; leé la política del plugin y de ML Kit. |

Verificá **locales soportados** y si hace falta **descarga por idioma** similar a Digital Ink o Translation.
