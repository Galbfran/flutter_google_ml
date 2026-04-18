# Google ML Kit en Flutter — índice

Este proyecto puede usar **plugins concretos** por función (recomendado en producción) en lugar del paraguas `google_ml_kit`, que incluye todo y aumenta mucho el tamaño de la app.

Cada archivo incluye:

- **Para qué sirve y cómo implementarlo** (casos de uso y pasos prácticos en Flutter).
- **Modelos y requisitos** (empaquetado en la app vs Google Play Services, descargas on-demand, red, plataformas).

Referencia general de Google sobre cómo se distribuyen los modelos: [ML Kit — model installation paths](https://developers.google.com/ml-kit/tips/installation-paths). Los detalles exactos pueden variar según la versión del plugin en pub.dev; validá siempre el README del paquete que agregues.

## Convención de nombres de archivo

| Prefijo | Significado |
|---------|-------------|
| **`android-ios-`** | Cubre **Android e iOS** (app Flutter móvil), según la matriz del ecosistema [flutter-ml/google_ml_kit_flutter](https://github.com/flutter-ml/google_ml_kit_flutter). |
| **`android-only-`** | **Solo Android** en esa matriz (o el plugin indica Android por ahora). **No** incluye **macOS de escritorio**: estos plugins ML Kit no sustituyen a un target `macos` de Flutter. |

Si un plugin añade soporte iOS en el futuro, conviene renombrar el archivo y actualizar este índice.

## Visión (Vision)

| Archivo | Plugin sugerido |
|--------|------------------|
| [Escaneo de códigos de barras](android-ios-vision-barcode-scanning.md) | `google_mlkit_barcode_scanning` |
| [Detección de rostros](android-ios-vision-face-detection.md) | `google_mlkit_face_detection` |
| [Malla facial (beta)](android-only-vision-face-mesh-detection.md) | `google_mlkit_face_mesh_detection` |
| [Reconocimiento de texto v2](android-ios-vision-text-recognition.md) | `google_mlkit_text_recognition` |
| [Etiquetado de imágenes](android-ios-vision-image-labeling.md) | `google_mlkit_image_labeling` |
| [Detección y seguimiento de objetos](android-ios-vision-object-detection.md) | `google_mlkit_object_detection` |
| [Reconocimiento de tinta digital](android-ios-vision-digital-ink-recognition.md) | `google_mlkit_digital_ink_recognition` |
| [Detección de pose (beta)](android-ios-vision-pose-detection.md) | `google_mlkit_pose_detection` |
| [Segmentación selfie (beta)](android-ios-vision-selfie-segmentation.md) | `google_mlkit_selfie_segmentation` |
| [Segmentación de sujeto (beta)](android-only-vision-subject-segmentation.md) | `google_mlkit_subject_segmentation` |
| [Escáner de documentos (beta)](android-only-vision-document-scanner.md) | `google_mlkit_document_scanner` |

## Lenguaje natural (Natural Language)

| Archivo | Plugin sugerido |
|--------|------------------|
| [Identificación de idioma](android-ios-nlp-language-identification.md) | `google_mlkit_language_id` |
| [Traducción en dispositivo](android-ios-nlp-translation.md) | `google_mlkit_translation` |
| [Respuestas inteligentes](android-ios-nlp-smart-reply.md) | `google_mlkit_smart_reply` |
| [Extracción de entidades (beta)](android-ios-nlp-entity-extraction.md) | `google_mlkit_entity_extraction` |

## GenAI (on-device, según plugins disponibles)

| Archivo | Plugin sugerido |
|--------|------------------|
| [Descripción de imagen (GenAI)](android-only-genai-image-description.md) | `google_mlkit_genai_image_description` |
| [Prompt / asistencia de texto (GenAI)](android-only-genai-prompt.md) | `google_mlkit_genai_prompt` |
| [Corrección ortográfica (GenAI)](android-only-genai-proofreading.md) | `google_mlkit_genai_proofreading` |
| [Reescritura de texto (GenAI)](android-only-genai-rewriting.md) | `google_mlkit_genai_rewriting` |
| [Reconocimiento de voz (GenAI)](android-only-genai-speech-recognition.md) | `google_mlkit_genai_speech_recognition` |
| [Resumen de texto (GenAI)](android-only-genai-summarization.md) | `google_mlkit_genai_summarization` |

Consulta la documentación oficial de cada paquete en [pub.dev](https://pub.dev/packages/google_ml_kit) para requisitos por plataforma y ejemplos de uso.
