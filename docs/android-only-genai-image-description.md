# Descripción de imagen (GenAI) — solo Android

## Para qué sirve y cómo implementarlo

Genera una **descripción breve en lenguaje natural** de una imagen usando la **GenAI Image Description API** de ML Kit (vía plugin Flutter). Google la orienta a **títulos**, **texto alternativo (alt text)** y contextos donde el usuario no puede mirar la pantalla.

Casos típicos:

- **Accesibilidad** (lectores de pantalla).
- **Moderación asistida** o resumen visual.
- **Búsqueda** por descripción (con limitaciones de idioma y calidad).

**Implementación sugerida (Flutter):**

1. Usar `ImageDescriber()` del paquete **`google_mlkit_genai_image_description`**.
2. Llamar **`checkFeatureStatus()`** antes de usar la UI del feature:
   - Si el estado es **`downloadable`**, invocar **`downloadFeature`** y esperar la descarga del modelo.
   - Si es **`available`**, podés llamar **`runInference`** con los datos de imagen (`type` + `path` para archivo, según el README del paquete).
3. Cerrar el cliente con **`close()`** al terminar (p. ej. en `dispose`).
4. No tratar la salida como hechos verificados: los modelos pueden **inventar o omitir** detalles.

**Plataforma (importante):** según pub.dev y el repositorio **flutter-ml**, esta API está **disponible solo en Android** en la práctica; **iOS puede añadirse más adelante**. No asumas iOS hasta revisar la versión del plugin.

Plugin: [`google_mlkit_genai_image_description`](https://pub.dev/packages/google_mlkit_genai_image_description).

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Modelo **on-device** asociado a la GenAI Image Description API (Google documenta el flujo con cliente `ImageDescriber` y descarga previa del feature). No exponés un `.tflite` manual: el SDK gestiona el binario. |
| **Android** | La guía de ML Kit indica **API level 26+** para esta API. El plugin en pub.dev cita **minSdk 26**, **compileSdk / targetSdk 35**. Tu app global puede tener `minSdk 21`, pero **esta feature solo funcionará en dispositivos que cumplan el mínimo del API** (26+). |
| **AICore / dispositivo** | Los GenAI de ML Kit en Android dependen del ecosistema **AICore** (p. ej. acceso a modelos tipo **Gemini Nano** en dispositivos compatibles). Google advierte limitaciones: **bootloader desbloqueado**, dispositivos no soportados, etc. Comprobar siempre **`checkFeatureStatus()`** y manejar errores en UI. |
| **Idioma** | En la documentación oficial de Google, las descripciones están orientadas principalmente al **inglés**; más idiomas pueden añadirse después. |
| **Red** | Hace falta **conexión** para **descargar** el modelo/feature cuando aún no está en el dispositivo; la inferencia es local una vez disponible. |
| **Estado** | API en **beta**; puede haber cambios sin política de deprecación estricta. |

Referencia nativa: [GenAI Image Description API (Android)](https://developers.google.com/ml-kit/genai/image-description/android).

**Contraste con Image Labeling clásico:** Image Labeling devuelve **etiquetas con scores**; Image Description devuelve **una frase generada** (prosa corta).
