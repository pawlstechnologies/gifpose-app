// screens/main_view/viewmodels/dashboard_viewmodel.dart
import 'dart:developer';
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/screens/main_view/repo/main_view_repo.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/main_view/widgets/premium_feature_modal.dart';
import 'package:giftpose/screens/onboarding/models/alert_sub_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/alerts_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/create_payment_intent_request.dart';
import 'package:giftpose/screens/onboarding/models/create_payment_intent_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_alert_list_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_user_by_deviceid_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/get_report_listing_reponse.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_request.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_response.dart';
import 'package:giftpose/screens/onboarding/models/notification_response.dart';
import 'package:giftpose/screens/onboarding/models/report_listing_request.dart';
import 'package:giftpose/screens/onboarding/models/report_listing_response.dart';
import 'package:giftpose/screens/onboarding/models/search_alert_category_request.dart';
import 'package:giftpose/screens/onboarding/models/search_predictions_request.dart';
import 'package:giftpose/screens/onboarding/models/search_response.dart';
import 'package:giftpose/screens/onboarding/viewmodels/onboarding_viewmodel.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';
import 'package:giftpose/utils/constants/storage_keys.dart';
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

  // search Pagination properties
  int _currentPageSearch = 1;
  int _totalPagesSearch = 1;
  bool _hasReachedMaxSearch = false;
  bool _isLoadingMoreSearch = false;
  // Items list
  List<FetchItemsNearMeData> _items = [];
  List<FetchItemsNearMeData> get items => _items;

  // Items list
  List<SearchData> _itemsSearch = [];
  List<SearchData> get itemsSearch => _itemsSearch;

  // Getters for pagination state
  bool get hasReachedMax => _hasReachedMax;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  // Getters for pagination state
  bool get hasReachedMaxSearch => _hasReachedMaxSearch;
  bool get isLoadingMoreSearch => _isLoadingMoreSearch;
  int get currentPageSearch => _currentPageSearch;
  int get totalPagesSearch => _totalPagesSearch;
  String? deviceId;

  String? imel;
  bool _isDark = false;
  bool get isDark => _isDark;

  bool get isDarkMode {
    final theme = AdaptiveTheme.of(navigatorKey.currentContext!);
    return theme.mode == AdaptiveThemeMode.dark;
  }

  void toggleTheme(BuildContext context) {
    final theme = AdaptiveTheme.of(context);

    if (_isDark) {
      theme.setLight();
      _isDark = false;
    } else {
      theme.setDark();
      _isDark = true;
    }

    notifyListeners();
  }

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
    getDeviceId();
    Future.delayed(Duration(seconds: 2), () {
      fetchItemsNearMe();
      fetchNotification();
    });
    fetchAlertCategory();
    fetchReportList();
    fetchUserByDeviceId();
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

  // Reset search pagination (call this when refreshing or changing filters)
  void resetPaginationSearch() {
    _currentPageSearch = 1;
    _totalPagesSearch = 1;
    _hasReachedMaxSearch = false;
    _isLoadingMoreSearch = false;
    _items.clear();
  }

  final SecureStorageService secureStorageService =
      serviceLocator<SecureStorageService>();

  // Main fetch method with pagination
  Future<void> fetchItemsNearMe({bool isLoadMore = false}) async {
    String? deviceIdFromDb = await secureStorageService.read(
      key: StorageKeys.deviceId,
    );
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
        deviceID: deviceIdFromDb ?? deviceId ?? "",
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

  NetworkDataResponse<SearchResponse> _globalSearchResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<SearchResponse> get globalSearchResponse =>
      _globalSearchResponse;

  set globalSearchResponse(NetworkDataResponse<SearchResponse> value) {
    _globalSearchResponse = value;
    notifyListeners();
  }

  Future<void> search({
    required BuildContext context,
    bool isLoadMore = false,
    required List<String> keywords,
  }) async {
    try {
      globalSearchResponse = NetworkDataResponse.loading("");

      // Show loader
      // await LoaderPage.show(context);

      final response = await mainViewRepo.globalSearch(
        deviceId: deviceId ?? "",
        searchCategoryPredictionRequest: SearchCategoryPredictionRequest(
          keywords: keywords,
        ),
      );

      if (response.success == true) {
        globalSearchResponse = NetworkDataResponse.completed(response);
      } else {
        globalSearchResponse = NetworkDataResponse.error(
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
        // _totalPagesSearch = response.totalPages;
        _currentPageSearch = response.page;
      } else {}

      // Add new items to existing list
      if (isLoadMore) {
        _itemsSearch.addAll(response.data.items ?? []);
      } else {
        _itemsSearch = response.data.items ?? [];
      }

      // Check if we've reached the last page
      _hasReachedMax =
          _currentPage >= _totalPages || (response.data?.items.isEmpty ?? true);

      // Update response state
      globalSearchResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      if (isLoadMore) {
        // Handle load more error silently
        log('Error loading more items: $e');
        _isLoadingMore = false;
        notifyListeners();
      } else {
        globalSearchResponse = NetworkDataResponse.error(e.toString());
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

  NetworkDataResponse<FetchUserByDeviceId> _fetchUserByDeviceIdResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<FetchUserByDeviceId> get fetchUserByDeviceIdResponse =>
      _fetchUserByDeviceIdResponse;

  set fetchUserByDeviceIdResponse(
    NetworkDataResponse<FetchUserByDeviceId> value,
  ) {
    _fetchUserByDeviceIdResponse = value;
    notifyListeners();
  }

  Future<void> fetchUserByDeviceId() async {
    try {
      fetchUserByDeviceIdResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchUserById(
        deviceID: deviceId ?? "",
      );

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchUserByDeviceIdResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchUserByDeviceIdResponse = NetworkDataResponse.error(e.toString());
    }
  }

  NetworkDataResponse<HideItemResponse> _hideItemResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<HideItemResponse> get hideItemResponse =>
      _hideItemResponse;

  set hideItemResponse(NetworkDataResponse<HideItemResponse> value) {
    _hideItemResponse = value;
    notifyListeners();
  }

  Future<void> hideItem({required String id, required String deviceID}) async {
    try {
      hideItemResponse = NetworkDataResponse.loading("");

      final response = await mainViewRepo.hideItem(
        hideItemRequest: HideItemRequest(deviceId: deviceID ?? ""),
        id: id,
      );

      hideItemResponse = NetworkDataResponse.completed(response);

      if (hideItemResponse.message.toString() == "Item hidden successfully") {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: response.message ?? "",
        );

        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog
        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog

        fetchItemsNearMe(isLoadMore: false);
      } else {
        if (navigatorKey.currentContext!.mounted) {
          Navigator.of(
            navigatorKey.currentContext!,
            rootNavigator: true,
          ).pop(); // Dismiss dialog
        }
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: response.message ?? "",
        );
      }
    } catch (e) {
      hideItemResponse = NetworkDataResponse.error(e.toString());
    }
  }

  // mark item

  NetworkDataResponse<HideItemResponse> _markItemResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<HideItemResponse> get markItemResponse =>
      _markItemResponse;

  set markItemResponse(NetworkDataResponse<HideItemResponse> value) {
    _markItemResponse = value;
    notifyListeners();
  }

  Future<void> markItem({required String id}) async {
    try {
      markItemResponse = NetworkDataResponse.loading("");
      await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.markItemTaken(
        hideItemRequest: HideItemRequest(deviceId: deviceId ?? ""),
        deviceID: deviceId ?? "",
        id: id,
      );
      if (navigatorKey.currentContext!.mounted) {
        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog
      }
      if (markItemResponse.status == true) {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: response.message ?? "",
        );

        fetchItemsNearMe(isLoadMore: false);
      }

      markItemResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      markItemResponse = NetworkDataResponse.error(e.toString());
    }
  }

  NetworkDataResponse<ReportListingResponse> _reportListingResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<ReportListingResponse> get reportListingResponse =>
      _reportListingResponse;

  set reportListingResponse(NetworkDataResponse<ReportListingResponse> value) {
    _reportListingResponse = value;
    notifyListeners();
  }

  Future<void> reportListing({
    required BuildContext context,
    required String id,
    required String reason,
  }) async {
    try {
      reportListingResponse = NetworkDataResponse.loading("");

      // Show loader
      LoaderPage.show(context);

      final response = await mainViewRepo.reportListing(
        reportListingRequest: ReportListingRequest(
          deviceId: deviceId ?? "",
          reason: reason,
        ),
        id: id,
      );

      reportListingResponse = NetworkDataResponse.completed(response);

      if (navigatorKey.currentContext!.mounted) {
        Navigator.of(
          navigatorKey.currentContext!,
          rootNavigator: true,
        ).pop(); // Dismiss dialog
      }

      if (response.status == true) {
        Navigator.pushNamed(context, AppRoutes.dashboard);

        CustomToast.show(context: context, message: "Success");
      } else {
        final errorMessage = "Something went wrong";
        CustomToast.show(context: context, message: errorMessage);
      }
    } catch (e) {
      reportListingResponse = NetworkDataResponse.error(e.toString());

      if (context.mounted) {
        Navigator.pop(context);
        CustomToast.show(context: context, message: e.toString());
      }
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
      LoaderPage.show(context);

      final response = await mainViewRepo.createNotificationAlerts(
        createAlertListRequest: CreateAlertListRequest(
          deviceId: deviceId ?? "",
          categories: categories,
          keywords: keywords,
          status: "Active",
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

        CustomToast.show(context: context, message: "Notification alert set");
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

  bool toggleKeyword(String keyword) {
    if (_selectedKeywords.contains(keyword)) {
      _selectedKeywords.remove(keyword);
      notifyListeners();
      return true;
    }

    final int maxKeywords =
        fetchUserByDeviceIdResponse.data?.data.isPremium == true ? 80 : 3;

    if (_selectedKeywords.length < maxKeywords) {
      _selectedKeywords.add(keyword);
      notifyListeners();
      return true;
    }

    print("VM: LIMIT REACHED. Returning false to UI.");
    print("TRIGGERING MODAL");
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PremiumFeaturesModal(),
    );
    return false;
  }

  List<String> _selectedCategory = [];
  List<String> get selectedCategory => _selectedCategory;

  void selectedCategoryKeyword(List<String> value) {
    _selectedCategory = value;
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
      // await LoaderPage.show(context);

      final response = await mainViewRepo.searchAlertPredictions(
        searchCategoryPredictionRequest: SearchCategoryPredictionRequest(
          keywords: keywords,
        ),
      );

      searchPredictionResponse = NetworkDataResponse.completed(response);

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(
      //     navigatorKey.currentContext!,
      //     rootNavigator: true,
      //   ).pop(); // Dismiss dialog
      // }

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

  NetworkDataResponse<GetReportListResponse> _fetchReportListResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<GetReportListResponse> get fetchReportListResponse =>
      _fetchReportListResponse;

  set fetchReportListResponse(
    NetworkDataResponse<GetReportListResponse> value,
  ) {
    _fetchReportListResponse = value;
    notifyListeners();
  }

  Future<void> fetchReportList() async {
    try {
      fetchReportListResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.getReportList();

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchReportListResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchReportListResponse = NetworkDataResponse.error(e.toString());
    }
  }

    NetworkDataResponse<CreateAlertListResponse>
  _createAlertListResponse = NetworkDataResponse.idle();

  NetworkDataResponse<CreateAlertListResponse>
  get createAlertListResponse => _createAlertListResponse;

  set createAlertListResponse(
    NetworkDataResponse<CreateAlertListResponse> value,
  ) {
    _createAlertListResponse = value;
    notifyListeners();
  }

  Future<void> createAlertList({required List<String> selectedCategory, required List<String> selectedKeywords}) async {
    try {
      createAlertListResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

        final response = await mainViewRepo.createAlertList(
          createAlertListRequest: CreateAlertListRequest(firebaseToken:  fcmToken ??"", deviceId: deviceId??"", categories: selectedCategory, keywords: selectedKeywords, status: "active")
        );

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      createAlertListResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      createAlertListResponse = NetworkDataResponse.error(e.toString());
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

  NetworkDataResponse<CreatePaymentIntentResponse>
  _createPaymentIntentResponse = NetworkDataResponse.idle();

  NetworkDataResponse<CreatePaymentIntentResponse>
  get createPaymentIntentResponse => _createPaymentIntentResponse;

  set createPaymentIntentResponse(
    NetworkDataResponse<CreatePaymentIntentResponse> value,
  ) {
    _createPaymentIntentResponse = value;
    notifyListeners();
  }

  Future<void> createPaymentIntent({required String plan}) async {
    try {
      print("🟡 STEP 1: شروع createPaymentIntent");

      createPaymentIntentResponse = NetworkDataResponse.loading("");

      if (deviceId == null || deviceId!.isEmpty) {
        String? deviceIdFromDb = await secureStorageService.read(
          key: StorageKeys.deviceId,
        );
        deviceId = deviceIdFromDb;
      }
      if (deviceId == null || deviceId!.isEmpty) {
        await getDeviceId();
      }

      final response = await mainViewRepo.createPaymentIntent(
        createPaymentIntentRequest: CreatePaymentIntentRequest(
          deviceId: deviceId ?? "",
          plan: plan,
        ),
      );

      print("🟢 STEP 2: API RESPONSE RECEIVED");
      print("👉 Full response: $response");

      createPaymentIntentResponse = NetworkDataResponse.completed(response);

      final clientSecret =
          createPaymentIntentResponse.data?.data.clientSecret ?? "";

      print("🟢 STEP 3: CLIENT SECRET");
      print("👉 $clientSecret");

      if (clientSecret.isEmpty) {
        print("🔴 ERROR: Client secret is EMPTY");
        createPaymentIntentResponse = NetworkDataResponse.error("Client secret is empty");
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: "Unable to initialize payment details. Please try again.",
        );
        return;
      }

      print("🟡 STEP 4: INITIALIZING PAYMENT SHEET");

      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'GiftPose',

            // 👇 Add this for Android
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'NG',
              testEnv: false,
            ),
          ),
        );

        print("🟢 STEP 5: PAYMENT SHEET INITIALIZED");
      } on StripeException catch (e) {
        print("🔴 StripeException during initPaymentSheet");
        createPaymentIntentResponse = NetworkDataResponse.error(e.error.localizedMessage ?? e.toString());
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: e.error.localizedMessage ?? "Stripe initialization failed.",
        );
        return;
      } catch (e, s) {
        print("🔴 ERROR DURING initPaymentSheet");
        print(e);
        print(s);
        createPaymentIntentResponse = NetworkDataResponse.error(e.toString());
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: "Failed to load payment options.",
        );
        return;
      }

      print("🟡 STEP 6: PRESENTING PAYMENT SHEET");

      try {
        await Stripe.instance.presentPaymentSheet();
        print("🟢 STEP 7: PAYMENT SHEET CLOSED (SUCCESS)");
        createPaymentIntentResponse = NetworkDataResponse.completed(response);
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          AppRoutes.createAccountPage,
        );
      } on StripeException catch (e) {
        print("🔴 StripeException during presentPaymentSheet");
        if (e.error.code == FailureCode.Canceled) {
          print("User canceled payment");
          createPaymentIntentResponse = NetworkDataResponse.idle();
        } else {
          createPaymentIntentResponse = NetworkDataResponse.error(e.error.localizedMessage ?? e.toString());
          CustomToast.show(
            context: navigatorKey.currentContext!,
            message: e.error.localizedMessage ?? "Payment failed.",
          );
        }
      } catch (e, s) {
        print("🔴 ERROR DURING presentPaymentSheet");
        print(e);
        print(s);
        createPaymentIntentResponse = NetworkDataResponse.error(e.toString());
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message: "An unexpected error occurred during payment.",
        );
      }

      print("🟡 STEP 8: DONE");
    } catch (e, s) {
      print("🔥 FATAL ERROR");
      print(e);
      print(s);

      String errorMsg = e.toString();
      if (e is Future) {
        errorMsg = "Connection issue. Please check your network and try again.";
      }
      createPaymentIntentResponse = NetworkDataResponse.error(errorMsg);
      CustomToast.show(
        context: navigatorKey.currentContext!,
        message: errorMsg,
      );
    }
  }

  NetworkDataResponse<FetchAlertListResponse> _fetchAlertListResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<FetchAlertListResponse> get fetchAlertListResponse =>
      _fetchAlertListResponse;

  set fetchAlertListResponse(
    NetworkDataResponse<FetchAlertListResponse> value,
  ) {
    _fetchAlertListResponse = value;
    notifyListeners();
  }

  Future<void> fetchAlertList() async {
    try {
      String? deviceIdFromDb = await secureStorageService.read(
        key: StorageKeys.deviceId,
      );
      fetchAlertListResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchAlertList(
        deviceID: deviceIdFromDb ?? deviceId ?? "",
      );
      // Collect all keywords from all alerts and ensure uniqueness

      _selectedKeywords.addAll(
        response.data.expand((datum) => datum.keywords).toSet().toList(),
        
      );
       notifyListeners();
      // _selectedKeywords.add(response.data.data); // Fixed: removed invalid getter usage
      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchAlertListResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchAlertListResponse = NetworkDataResponse.error(e.toString());
    }
  }

  NetworkDataResponse<NotificationResponse> _fetchNotificationResponse =
      NetworkDataResponse.idle();
  NetworkDataResponse<NotificationResponse> get fetchNotificationResponse =>
      _fetchNotificationResponse;

  set fetchNotificationResponse(
    NetworkDataResponse<NotificationResponse> value,
  ) {
    _fetchNotificationResponse = value;
    notifyListeners();
  }

  Future<void> fetchNotification() async {
    try {
      String? deviceIdFromDb = await secureStorageService.read(
        key: StorageKeys.deviceId,
      );
      fetchNotificationResponse = NetworkDataResponse.loading("");
      // await LoaderPage.show(navigatorKey.currentContext!);

      final response = await mainViewRepo.fetchNotification(
        deviceID: deviceIdFromDb ?? deviceId ?? "",
      );

      // if (navigatorKey.currentContext!.mounted) {
      //   Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
      // }

      fetchNotificationResponse = NetworkDataResponse.completed(response);
    } catch (e) {
      fetchNotificationResponse = NetworkDataResponse.error(e.toString());
    }
  }
}
