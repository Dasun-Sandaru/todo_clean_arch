import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import 'auth_token_storage.dart';

class DioClient {
  late final Dio _dio;
  final AuthTokenStorage _authTokenStorage;

  DioClient(this._authTokenStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        // request interceptor attach access token automatically
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              final token = await _authTokenStorage.getAccessToken();
              if (token != null && token.isNotEmpty) {
                options.headers["Authorization"] = "Bearer $token";
              }
              return handler.next(options);
            },

        // response interception pass through
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },

        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await _authTokenStorage.getRefreshToken();
            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                // separate Dio instance for Token Refresh to prevent infinite interceptor loops
                final refreshDio = Dio(
                  BaseOptions(baseUrl: ApiConstants.baseUrl),
                );
                final response = await refreshDio.post(
                  ApiConstants.refreshTokenEndpoint,
                  data: {'refresh_token': refreshToken},
                );

                if (response.statusCode == 200 || response.statusCode == 201) {
                  final newAccessToken = response.data['access_token'];
                  final newRefreshToken = response.data['refresh_token'];

                  // save new tokens locally
                  await _authTokenStorage.saveTokens(
                    accessToken: newAccessToken,
                    refreshToken: newRefreshToken,
                  );

                  // update original request headers with new Access Token
                  error.requestOptions.headers["Authorization"] =
                      "Bearer $newAccessToken";

                  // retry the failed original request using dio instance
                  final colnedRequest = await _dio.fetch(error.requestOptions);
                  return handler.resolve(colnedRequest);
                }
              } catch (refreshError) {
                // refresh token expired or invalid -> logout user
                await _authTokenStorage.clearTokens();
                // return handler.next(error);
                // Optionally trigger a global auth event / stream to send user ti login screen
              }
            }
          }
        },
      ),
    );
  }

  // GET request wrapper
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // POST request wrapper
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PUT request wrapper
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PATCH request wrapper
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // DELETE request wrapper
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // map low-level DioException to app custom domain exceptions
  AppException _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(
          message: "No internet connection or server timeout.",
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final serverMsg =
            error.response?.data['message'] ?? "An error occurred.";

        if (statusCode == 400) {
          return BadRequestException(message: serverMsg);
        } else if (statusCode == 401) {
          return UnauthorizedException(message: serverMsg);
        } else if (statusCode == 403) {
          return ForbiddenException(message: serverMsg);
        } else if (statusCode == 404) {
          return NotFoundException(message: serverMsg);
        } else if (statusCode == 409) {
          return ConflictException(message: serverMsg);
        } else if (statusCode == 500) {
          return ServerException(serverMsg);
        } else {
          return ServerException(serverMsg);
        }

      case DioExceptionType.cancel:
        return RequestCancelledException(message: "Request was cancelled.");
      case DioExceptionType.unknown:
      default:
        return ServerException();
    }
  }
}
