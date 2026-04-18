# Extracción de entidades — beta — Android e iOS

## Para qué sirve y cómo implementarlo

A partir de texto libre, identifica **entidades estructuradas**: fechas, direcciones, montos, nombres propios, etc., según lo que el modelo cubra en tu idioma. Sirve para:

- **Rellenar formularios** desde un párrafo pegado (“el martes a las 15 en …”).
- **Agendar** eventos o recordatorios desde mensajes.
- **Normalizar** datos para CRM sin que el usuario escriba campo por campo.

**Implementación sugerida:**

1. Verificar **idiomas soportados** y si hace falta **descargar modelo** por idioma.
2. Validar siempre con reglas de negocio (la extracción puede equivocarse en fechas ambiguas).
3. Tratar la salida como **candidatos** con offsets en el texto para resaltar en UI.

Plugin: `google_mlkit_entity_extraction`.

## Modelos y requisitos

| Aspecto | Detalle |
|--------|---------|
| **Modelos** | Modelos de **NER / extracción** por idioma o configuración del SDK; muchas veces requieren **descarga** o actualización (consultá guía ML Kit Entity Extraction para tu versión). |
| **Beta** | Comportamiento y cobertura pueden cambiar entre releases. |
| **Red** | Puede ser necesaria para **obtener o actualizar** el modelo; la extracción en sí suele ser on-device. |
| **Privacidad** | El procesamiento típico es local tras tener el modelo, alineado con políticas on-device de ML Kit. |

Para entidades **muy de dominio** (códigos internos), puede hacer falta combinar con reglas o un modelo custom fuera de ML Kit.
