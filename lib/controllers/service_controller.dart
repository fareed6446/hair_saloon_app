import 'package:get/get.dart';
import '../models/service_model.dart';
import '../services/api_service.dart';
import '../services/hive_service.dart';

class ServiceController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final Rx<ServiceModel?> selectedService = Rx<ServiceModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadCachedServices();
    fetchServices();
  }

  void _loadCachedServices() {
    final cachedServices = HiveService.getServices();
    if (cachedServices.isNotEmpty) {
      services.value = cachedServices;
    }
  }

  Future<void> fetchServices({bool refresh = false}) async {
    try {
      if (refresh) {
        isRefreshing.value = true;
      } else {
        isLoading.value = true;
      }

      final response = await _apiService.getServices();
      final fetchedServices = response
          .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();

      services.value = fetchedServices;

      // Save to local storage
      await HiveService.saveServices(fetchedServices);

      if (refresh) {
        Get.snackbar(
          'Success',
          'Services refreshed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load services: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  Future<void> fetchServiceDetail(String serviceId) async {
    try {
      isLoading.value = true;

      final response = await _apiService.getService(serviceId);
      final service = ServiceModel.fromJson(response);

      selectedService.value = service;

      // Update in list if exists
      final index = services.indexWhere((s) => s.id == serviceId);
      if (index != -1) {
        services[index] = service;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load service details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectService(ServiceModel service) {
    selectedService.value = service;
  }

  void clearSelectedService() {
    selectedService.value = null;
  }

  List<ServiceModel> get activeServices {
    return services.where((service) => service.isActive).toList();
  }

  ServiceModel? getServiceById(String id) {
    try {
      return services.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }
}
