import 'package:equatable/equatable.dart';

/// Resultado de OCR listo para la capa de presentación.
final class RecognizedTextResult extends Equatable {
  const RecognizedTextResult({
    required this.fullText,
    required this.lines,
  });

  final String fullText;
  final List<String> lines;

  static const RecognizedTextResult empty = RecognizedTextResult(
    fullText: '',
    lines: [],
  );

  @override
  List<Object?> get props => [fullText, lines];
}
