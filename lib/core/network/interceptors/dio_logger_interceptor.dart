import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Interceptor que registra peticiones, respuestas y errores con [Logger].
final class DioLoggerInterceptor extends Interceptor {
  DioLoggerInterceptor([Logger? logger])
      : _log = logger ??
            Logger(
              printer: PrettyPrinter(
                methodCount: 0,
                errorMethodCount: 8,
                lineLength: 120,
                colors: true,
                printEmojis: true,
              ),
            );

  final Logger _log;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _log.d(
      '${options.method} ${options.uri}\n'
      'headers: ${options.headers}\n'
      'data: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log.i(
      '${response.statusCode} ${response.requestOptions.uri}\n'
      '${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    _log.e(
      'DioException: ${err.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
