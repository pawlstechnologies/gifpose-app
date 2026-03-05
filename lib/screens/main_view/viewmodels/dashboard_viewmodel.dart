// screens/main_view/viewmodels/dashboard_viewmodel.dart
import 'dart:developer';
import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/screens/main_view/repo/main_view_repo.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/onboarding/models/alert_sub_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/alerts_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/search_alert_category_request.dart';
import 'package:giftpose/screens/onboarding/models/search_predictions_request.dart';
import 'package:giftpose/screens/onboarding/viewmodels/onboarding_viewmodel.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/network_data_response.dart';
import 'package:giftpose/utils/router/app_routes.dart' show AppRoutes;
import 'package:giftpose/utils/widgets/giftpose_toast.dart';
import 'package:giftpose/utils/widgets/loader_page.dart';
import 'package:provider/provider.dart';

class DashboardViewmodel extends BaseViewmodel {
  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController countryCodeCtrl = TextEditingController(
    text: "+234",
  );
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  String verificationId = "";

  // Pagination properties
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasReachedMax = false;
  bool _isLoadingMore = false;

  // Items list
  List<FetchItemsNearMeData> _items = [];
  List<FetchItemsNearMeData> get items => _items;

  // Getters for pagination state
  bool get hasReachedMax => _hasReachedMax;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  String? deviceId;

  String? imel;

  // fetch device details
  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late IosDeviceInfo iosInfo;
    ClientInformation info = await ClientInformation.fetch();
    log('deviceName ${info.deviceName}');
    log('deviceId ${info.deviceId}');
    late AndroidDeviceInfo androidInfo;
    if (Platform.isAndroid) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = "214356743";

      // });
      print(imel);
      androidInfo = await deviceInfo.androidInfo;
      // imel = "21345t5y65";
      deviceId = info.deviceId;
      dailcode = androidInfo.id;
      log('deviceID: $deviceId');
    } else if (Platform.isIOS) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = value;
      // });
      iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor;
      log('deviceID ios : $deviceId');
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    otpCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCtrl.dispose();
    countryCodeCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void clearTextControllers() {
    passwordCtrl.clear();
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    countryCtrl.clear();
    phoneCtrl.clear();
    cityCtrl.clear();
    notifyListeners();
  }

  DashboardViewmodel() {
    getDeviceId();
    Future.delayed(const Duration(seconds: 2), () {
      fetchItemsNearMe();
    });
    fetchAlertCategory();
  }

  final MainViewRepo mainViewRepo = serviceLocator<MainViewRepo>();

  int _miles = 0;
  int get miles => _miles;

  set miles(int value) {
    _miles = value;
    notifyListeners();
  }

  NetworkDataResponse<FetchItemsNearMeResponse> _fetchItemsNearMeResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<FetchItemsNearMeResponse> get fetchItemsNearMeResponse =>
      _fetchItemsNearMeResponse;

  set fetchItemsNearMeResponse(
    NetworkDataResponse<FetchItemsNearMeResponse> value,
  ) {
    _fetchItemsNearMeResponse = value;
    notifyListeners();
  }

  // Reset pagination (call this when refreshing or changing filters)
  void resetPagination() {
    _currentPage = 1;
    _totalPages = 1;
    _hasReachedMax = false;
    _isLoadingMore = false;
    _items.clear();
  }

  // Main fetch method with pagination
  Future<void> fetchItemsNearMe({bool isLoadMore = false}) async {
    // Prevent multiple simultaneous loads
    if (_isLoadingMore) return;

    // Check if we've reached the last page
    if (isLoadMore && _hasReachedMax) return;

    try {
      final onboardingVM = Provider.of<OnboardingViewModel>(
        navigatorKey.currentContext!,
        listen: false,
      );
      deviceId = onboardingVM.deviceId;
      log('device id $deviceId');
      if (isLoadMore) {
        _isLoadingMore = true;
        notifyListeners();
      } else {
        // Reset for fresh load
        resetPagination();
        fetchItemsNearMeResponse = NetworkDataResponse.loading("");
      }

      // Make API call with pagination parameters
      final response = await mainViewRepo.fetchItemsNearme(
        page: _currentPage.toString(),
        deviceID: deviceId ?? "",
      );
      if (response.success == true) {
        fetchItemsNearMeResponse = NetworkDataResponse.completed(response);
      } else {
        fetchItemsNearMeResponse = NetworkDataResponse.error(
          response.message ?? "Something went wrong",
        );
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: response.message ?? "Something went wrong",
        );
      }

      // Update total pages from response (adjust based on your API response structure)
      // Assuming your response has pagination info
      if (response.page != null) {
        _totalPages = response.totalPages;
        _currentPage = response.page;
      } else {}

      // Add new items to existing list
      if (isLoadMore) {
        _items.addAll(response.data ?? []);
      } else {
        _items = response.data ?? [];
      }

      // Check if we've reached the last page
      _hasReachedMax =
          _currentPage >= _totalPages || (response.data?.isEmpty ?? true);

      // Update response state
      fetchItemsNearMeResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      if (isLoadMore) {
        // Handle load more error silently
        log('Error loading more items: $e');
        _isLoadingMore = false;
        notifyListeners();
      } else {
        fetchItemsNearMeResponse = NetworkDataResponse.error(e.toString());
      }
    } finally {
      if (isLoadMore) {
        _isLoadingMore = false;
        notifyListeners();
      }
    }
  }

  // Method to load next page (called when user scrolls to bottom)
  Future<void> loadNextPage() async {
    if (_hasReachedMax || _isLoadingMore) return;

    _currentPage++;
    await fetchItemsNearMe(isLoadMore: true);
  }

  // Refresh method (pull to refresh)
  Future<void> refreshItems() async {
    _currentPage = 1;
    await fetchItemsNearMe(isLoadMore: false);
  }

  NetworkDataResponse<FetchItemsbyIdResponse> _fetchItemsByIdMeResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<FetchItemsbyIdResponse> get fetchItemsByIdMeResponse =>
      _fetchItemsByIdMeResponse;

  set fetchItemsByIdMeResponse(
    NetworkDataResponse<FetchItemsbyIdResponse> value,
  ) {
    _fetchItemsByIdMeResponse = value;
    notifyListeners();
  }

  Future<void> fetchItemsById({required String id}) async {
    try {
      fetchItemsByIdMeResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchItemsById(
        deviceID: deviceId ?? "",
        id: id,
      );

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchItemsByIdMeResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchItemsByIdMeResponse = NetworkDataResponse.error(e.toString());
    }
  }

  NetworkDataResponse<CreateAlertListResponse> _createAlertResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<CreateAlertListResponse> get createAlertResponse =>
      _createAlertResponse;

  set createAlertResponse(NetworkDataResponse<CreateAlertListResponse> value) {
    _createAlertResponse = value;
    notifyListeners();
  }

  Future<void> createNotificationAlerts({
    required BuildContext context,
    required List<String> categories,
    required List<String> keywords,
    required String status,
  }) async {
    try {
      createAlertResponse = NetworkDataResponse.loading("");

      // Show loader
      await LoaderPage.show(context);

      final response = await mainViewRepo.createNotificationAlerts(
        createAlertListRequest: CreateAlertListRequest(
          deviceId: deviceId ?? "",
          categories: categories,
          keywords: keywords,
          status: status,
          firebaseToken: fcmToken ?? "",
        ),
      );

      createAlertResponse = NetworkDataResponse.completed(response);

      if (navigatorKey.currentContext!.mounted) {
        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog
      }

      if (response.success == true) {
        Navigator.pushNamed(context, AppRoutes.dashboard);
      } else {
        final errorMessage = "Something went wrong";
        CustomToast.show(context: context, message: errorMessage);
      }
    } catch (e) {
      createAlertResponse = NetworkDataResponse.error(e.toString());

      if (context.mounted) {
        Navigator.pop(context);
        CustomToast.show(context: context, message: e.toString());
      }
    }
  }

  List<String> _selectedKeywords = [];
  List<String> get selectedKeywords => _selectedKeywords;

  set selectedKeywords(List<String> value) {
    _selectedKeywords = value;
    notifyListeners();
  }

  NetworkDataResponse<SearchCategoryPredictionResponse>
  _searchPredictionResponse = NetworkDataResponse.idle();

  NetworkDataResponse<SearchCategoryPredictionResponse>
  get searchPredictionResponse => _searchPredictionResponse;

  set searchPredictionResponse(
    NetworkDataResponse<SearchCategoryPredictionResponse> value,
  ) {
    _searchPredictionResponse = value;
    notifyListeners();
  }

  Future<void> searchPrediction({
    required BuildContext context,

    required List<String> keywords,
  }) async {
    try {
      searchPredictionResponse = NetworkDataResponse.loading("");

      // Show loader
      await LoaderPage.show(context);

      final response = await mainViewRepo.searchAlertPredictions(
        searchCategoryPredictionRequest: SearchCategoryPredictionRequest(
          keywords: keywords,
        ),
      );

      searchPredictionResponse = NetworkDataResponse.completed(response);

      if (navigatorKey.currentContext!.mounted) {
        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog
      }

      if (response.success == true) {
      } else {
        final errorMessage = "Something went wrong";
        CustomToast.show(context: context, message: errorMessage);
      }
    } catch (e) {
      searchPredictionResponse = NetworkDataResponse.error(e.toString());

      if (context.mounted) {
        Navigator.pop(context);
        CustomToast.show(context: context, message: e.toString());
      }
    }
  }


  int _selectedIndex = -1;
int get selectedIndex => _selectedIndex;

void selectOption(int index) {
  _selectedIndex = index;
  notifyListeners();
}

  NetworkDataResponse<AlertListCategoryResponse> _fetchAlertCategoryResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<AlertListCategoryResponse>
  get fetchAlertCategoryResponse => _fetchAlertCategoryResponse;

  set fetchAlertCategoryResponse(
    NetworkDataResponse<AlertListCategoryResponse> value,
  ) {
    _fetchAlertCategoryResponse = value;
    notifyListeners();
  }

  Future<void> fetchAlertCategory() async {
    try {
      fetchAlertCategoryResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchAlertCategories();

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchAlertCategoryResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchAlertCategoryResponse = NetworkDataResponse.error(e.toString());
    }
  }

  NetworkDataResponse<AlertListSubCategoryResponse>
  _fetchAlertSubCategoryResponse = NetworkDataResponse.idle();

  NetworkDataResponse<AlertListSubCategoryResponse>
  get fetchAlertSubCategoryResponse => _fetchAlertSubCategoryResponse;

  set fetchAlertSubCategoryResponse(
    NetworkDataResponse<AlertListSubCategoryResponse> value,
  ) {
    _fetchAlertSubCategoryResponse = value;
    notifyListeners();
  }

  Future<void> fetchAlertSubCategory({required String categoryId}) async {
    try {
      fetchAlertSubCategoryResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchAlertSubCategories(
        categoryId: categoryId,
      );

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchAlertSubCategoryResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchAlertSubCategoryResponse = NetworkDataResponse.error(e.toString());
    }
  }
}
