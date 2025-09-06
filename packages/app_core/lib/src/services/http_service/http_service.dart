import 'package:app_core/src/services/http_service/abstract_http_service.dart';
import 'package:app_core/src/services/sercure_storage/abstract_secure_storage_service.dart';
import 'package:app_core/src/services/sercure_storage/sercure_storage_service.dart';
import 'package:dio/dio.dart';

class HttpService extends IHttpService {
  late Dio _dio;
  late ISecureStorageService _secureStorageService;

  HttpService({Dio? dio, ISecureStorageService? secureStorageService}) {
    _secureStorageService = secureStorageService ?? SecureStorageService();

    if (dio != null) {
      _dio = dio;
      return;
    }

    _dio = Dio(BaseOptions());
    //looking for the auth token from the secure storage and adding it to the headers
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get the auth token from secure storage
          final authToken = await _getAuthToken();
          if (authToken != null) {
            options.headers['Authorization'] = 'Bearer $authToken';
          }
          return handler.next(options);
        },
      ),
    );

    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<String?> _getAuthToken() async {
    return await _secureStorageService.read('token');
  }

  @override
  Future<HttpResponse<TResult>> get<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters, data: data, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 500,
        statusMessage: response.statusMessage,
        data: response.data != null ? fromJson(response.data as Map<String, dynamic>) : null,
      );
    } on DioException catch (e) {
      return HttpResponse(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage,
        data: null,
        originalResponse: e.response,
      );
    }
  }

  @override
  Future<HttpResponse<TResult>> post<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(path, queryParameters: queryParameters, data: data, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 500,
        statusMessage: response.statusMessage,
        data: response.data != null ? fromJson(response.data as Map<String, dynamic>) : null,
      );
    } on DioException catch (e) {
      return HttpResponse(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage,
        data: null,
        originalResponse: e.response,
      );
    }
  }

  @override
  Future<HttpResponse<TResult>> put<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(path, queryParameters: queryParameters, data: data, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 500,
        statusMessage: response.statusMessage,
        data: response.data != null ? fromJson(response.data as Map<String, dynamic>) : null,
      );
    } on DioException catch (e) {
      return HttpResponse(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage,
        data: null,
        originalResponse: e.response,
      );
    }
  }

  @override
  Future<HttpResponse<TResult>> patch<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(path, queryParameters: queryParameters, data: data, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 500,
        statusMessage: response.statusMessage,
        data: response.data != null ? fromJson(response.data as Map<String, dynamic>) : null,
      );
    } on DioException catch (e) {
      return HttpResponse(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage,
        data: null,
        originalResponse: e.response,
      );
    }
  }

  @override
  Future<HttpResponse<TResult>> delete<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(path, queryParameters: queryParameters, data: data, options: Options(headers: headers));
      return HttpResponse(
        statusCode: response.statusCode ?? 500,
        statusMessage: response.statusMessage,
        data: response.data != null ? fromJson(response.data as Map<String, dynamic>) : null,
      );
    } on DioException catch (e) {
      return HttpResponse(
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.response?.statusMessage,
        data: null,
        originalResponse: e.response,
      );
    }
  }
}
