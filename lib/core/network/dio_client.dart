import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:google_ml_kit/core/config/app_config.dart';
import 'package:google_ml_kit/core/network/interceptors/dio_logger_interceptor.dart';

/// Fábrica de [Dio] con opciones base e interceptores comunes.
///
/// Uso sugerido: una instancia por app (inyectada en `main` / router).
final class DioClient {
  DioClient({
    String baseUrl = AppConfig.apiBaseUrl,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
    List<Interceptor> interceptors = const [],
    bool enableLogging = true,
    Logger? logger,
  })  : _baseUrl = baseUrl,
        _connectTimeout = connectTimeout,
        _receiveTimeout = receiveTimeout,
        _extraInterceptors = interceptors,
        _enableLogging = enableLogging,
        _logger = logger;

  final String _baseUrl;
  final Duration _connectTimeout;
  final Duration _receiveTimeout;
  final List<Interceptor> _extraInterceptors;
  final bool _enableLogging;
  final Logger? _logger;

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (_enableLogging) {
      dio.interceptors.add(DioLoggerInterceptor(_logger));
    }
    dio.interceptors.addAll(_extraInterceptors);
    return dio;
  }
}
