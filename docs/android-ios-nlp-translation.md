# Traducción en el dispositivo — Android e iOS

## Para qué sirve y cómo implementarlo

Traduce texto entre **pares de idiomas** soportados usando modelos **descargables** que corren en el teléfono. Ideal cuando necesitás:

- **Privacidad** (el texto no sale del dispositivo).
- **Modo avión** o redes inestables tras descargar modelos.
- Reducir coste de APIs cloud.

**Implementación sugerida:**

1. Antes de traducir, comprobar que los modelos del **origen → destino** están **descargados** (`downloadModel` / APIs del plugin).
2. Ofrecer en ajustes **“Descargar idiomas”** con tamaño aproximado y uso de Wi‑Fi.
3. Manejar **límites de longitud** y errores si falta el par de modelos.

Plugin: `google_mlkit_translation`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelos** | ML Kit usa modelos de traducción **neuronales por par de idiomas**; se gestionan como **descarga dinámica** (tabla ML Kit: Translation → dynamically downloaded). |
| **Almacenamiento** | Cada par descargado ocupa espacio en almacenamiento de la app; podés **eliminar** modelos no usados con la API del SDK. |
| **Red** | **Imprescindible** para **descargar** o **actualizar** modelos; la inferencia de traducción es local. |
| **Calidad** | Inferior a servicios cloud de última generación en algunos pares; validá con tus textos reales. |

Consultá la lista actual de **idiomas soportados** en la documentación de ML Kit Translation.
