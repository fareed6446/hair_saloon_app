import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/hive_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final user = HiveService.getCurrentUser();
    final token = HiveService.getToken();

    if (user != null && token != null) {
      currentUser.value = user;
      isAuthenticated.value = true;
    }
  }

  Future<bool> register({
    required String fullName,
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await _apiService.register(
        fullName: fullName,
        phone: phone,
        password: password,
      );

      // Extract token
      final token = response['token'] ?? response['access_token'];
      if (token != null) {
        await HiveService.saveToken(token);
      }

      // Extract and save user
      if (response['user'] != null) {
        final user = UserModel.fromJson(response['user']);
        await HiveService.saveUser(user);
        currentUser.value = user;
        isAuthenticated.value = true;
      }

      Get.snackbar(
        'Success',
        'Registration successful!',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login({required String phone, required String password}) async {
    try {
      isLoading.value = true;

      final response = await _apiService.login(
        phone: phone,
        password: password,
      );

      // Extract token
      final token = response['token'] ?? response['access_token'];
      if (token != null) {
        await HiveService.saveToken(token);
      }

      // Extract and save user
      if (response['user'] != null) {
        final user = UserModel.fromJson(response['user']);
        await HiveService.saveUser(user);
        currentUser.value = user;
        isAuthenticated.value = true;
      }

      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Call API logout
      await _apiService.logout();

      // Clear local data
      await HiveService.clearAllData();

      currentUser.value = null;
      isAuthenticated.value = false;

      Get.offAllNamed('/login');

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUserData() async {
    try {
      final response = await _apiService.getMe();
      final user = UserModel.fromJson(response);
      await HiveService.saveUser(user);
      currentUser.value = user;
    } catch (e) {
      print('Failed to refresh user data: $e');
    }
  }

  void updateLoyaltyPoints(int points) {
    if (currentUser.value != null) {
      currentUser.value!.loyaltyPoints = points;
      HiveService.saveUser(currentUser.value!);
      currentUser.refresh();
    }
  }

  String? get userId => currentUser.value?.id;
  int get loyaltyPoints => currentUser.value?.loyaltyPoints ?? 0;
}
