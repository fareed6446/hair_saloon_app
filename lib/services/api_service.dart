import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../constants/app_constants.dart';
import 'hive_service.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = HiveService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (error, handler) async {
          print(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );

          // Handle 401 Unauthorized - logout user
          if (error.response?.statusCode == 401) {
            await HiveService.clearAllData();
            getx.Get.offAllNamed('/login');
          }

          return handler.next(error);
        },
      ),
    );
  }

  // Helper method to handle API errors
  String _handleError(DioException error) {
    String errorMessage = 'An error occurred';

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Connection timeout';
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = 'No internet connection';
    } else if (error.response != null) {
      final data = error.response?.data;
      if (data is Map && data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (data is Map && data.containsKey('error')) {
        errorMessage = data['error'];
      } else {
        errorMessage = 'Server error: ${error.response?.statusCode}';
      }
    }

    return errorMessage;
  }

  // Auth APIs
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.registerEndpoint,
        data: {'fullName': fullName, 'phone': phone, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.loginEndpoint,
        data: {'phone': phone, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    try {
      final response = await _dio.get(AppConstants.meEndpoint);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(AppConstants.logoutEndpoint);
    } on DioException catch (e) {
      // Ignore logout errors
      print('Logout error: ${_handleError(e)}');
    }
  }

  // Service APIs
  Future<List<dynamic>> getServices() async {
    try {
      final response = await _dio.get(AppConstants.servicesEndpoint);
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getService(String id) async {
    try {
      final response = await _dio.get('${AppConstants.servicesEndpoint}/$id');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Time Slot APIs
  Future<Map<String, dynamic>> getTimeSlots({
    required String serviceId,
    required String date,
  }) async {
    try {
      final response = await _dio.get(
        AppConstants.timeSlotsEndpoint,
        queryParameters: {'serviceId': serviceId, 'date': date},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Booking APIs
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        AppConstants.bookingsEndpoint,
        data: data,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<dynamic>> getUserBookings(String userId) async {
    try {
      final response = await _dio.get('/users/$userId/bookings');
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<dynamic>> getAllBookings() async {
    try {
      final response = await _dio.get(AppConstants.bookingsEndpoint);
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getBooking(String id) async {
    try {
      final response = await _dio.get('${AppConstants.bookingsEndpoint}/$id');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> cancelBooking(String id) async {
    try {
      final response = await _dio.post(
        '${AppConstants.bookingsEndpoint}/$id/cancel',
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Notification APIs
  Future<List<dynamic>> getNotifications() async {
    try {
      final response = await _dio.get(AppConstants.notificationsEndpoint);
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> markNotificationAsRead(String id) async {
    try {
      final response = await _dio.post(
        '${AppConstants.notificationsEndpoint}/$id/read',
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
