# Identificación de idioma — Android e iOS

## Para qué sirve y cómo implementarlo

Dado un **fragmento de texto**, estima el **idioma** (o candidatos con confianza). Sirve para:

- Elegir automáticamente **modelo de traducción** o **diccionario**.
- Enrutar contenido en apps **multilingües**.
- Filtrar mensajes antes de procesarlos con otra API.

**Implementación sugerida:**

1. Usar textos de **longitud mínima razonable** (muy cortos pueden fallar).
2. No exponer el idioma como verdad absoluta: mostrar al usuario opción de cambiar si la confianza es baja.
3. Combinar con **Translation** solo después de confirmar idioma origen si ahorra descargas de modelos.

Plugin: `google_mlkit_language_id`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelo** | Clasificador de idioma compacto de ML Kit. |
| **Android** | Soporta **unbundled** (Play Services) y **bundled**; bundled aumenta APK pero evita esperar descarga. |
| **iOS** | Incluido en el stack nativo del plugin. |
| **Red** | Inferencia **local** con modelo disponible; primera descarga posible si usás variante unbundled en Android. |

No traduce ni resume: **solo clasifica** el idioma del texto de entrada.
