import 'package:equatable/equatable.dart';

class HttpResponse<T> extends Equatable {
  final int statusCode;
  final String? statusMessage;
  final T? data;
  final dynamic originalResponse;

  const HttpResponse({required this.statusCode, this.statusMessage, this.data, this.originalResponse});

  @override
  List<Object?> get props => [statusCode, statusMessage, data, originalResponse];
}

abstract class IHttpService {
  Future<HttpResponse<TResult>> get<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse<TResult>> post<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse<TResult>> put<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse<TResult>> patch<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse<TResult>> delete<TResult>(
    String path,
    TResult Function(Map<String, dynamic> data) fromJson, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
}
