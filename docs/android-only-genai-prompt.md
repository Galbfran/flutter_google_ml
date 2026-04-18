# Asistencia con prompts (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

Asiste en tareas de texto guiadas por **instrucciones** (prompt), dentro de lo que el modelo on-device permita: borradores, reformulaciones ligeras o completar ideas según la API expuesta por el plugin.

**Implementación sugerida:**

1. Definir **límites de producto**: qué tipos de prompt permitís (seguridad, cumplimiento).
2. Mostrar **descargo de responsabilidad** si el usuario pide contenido sensible.
3. Medir **tokens / longitud** y tiempo de respuesta en dispositivos gama media.

Plugin: `google_mlkit_genai_prompt`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo de lenguaje **generativo compacto** distribuido con el stack GenAI de ML Kit para Flutter (detalle por versión en pub.dev). |
| **Hardware** | Similar al resto de GenAI: puede haber requisitos de **NNAPI / GPU / memoria** en Android y equivalentes en iOS. |
| **Red** | Suele requerirse para **descargar** el binario del modelo la primera vez; uso posterior mayormente local. |
| **Alcance** | No es un chat de propósito general ilimitado: capacidades acotadas al **fine-tuning** y tamaño del modelo embebido. |

Revisá si el plugin expone **temperatura**, **contexto máximo** o plantillas recomendadas.
