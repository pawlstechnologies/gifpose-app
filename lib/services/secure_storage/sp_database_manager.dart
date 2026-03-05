import 'dart:convert';


import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpDatabaseManager {
  static final SpDatabaseManager _sessionManager = SpDatabaseManager.internal();
  factory SpDatabaseManager() => _sessionManager;
  SpDatabaseManager.internal();

  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Future<void> saveTimeoutManager({required bool manager}) async {
  //   sharedPreferences.setBool(StorageKeys.manager, manager);
  // }

  // Future<bool?> getTimeoutManager() async {
  //   bool? manager = sharedPreferences.getBool(StorageKeys.manager);
  //   return manager ?? false;
  // }

  // Future<void> saveFontSizeOption({required double appFontSize}) async {
  //   sharedPreferences.setDouble(StorageKeys.fontSize, appFontSize);
  // }

  // Future<double?> getFontSizeOption() async {
  //   double? appFontSize = sharedPreferences.getDouble(StorageKeys.fontSize);
  //   return appFontSize ?? 1.0;
  // }

  // Future<void> saveRememberMeStatus({required bool status}) async {
  //   sharedPreferences.setBool(StorageKeys.rememberMeStatus, status);
  // }

  // Future<bool?> getRememberMeStatus() async {
  //   bool? status = sharedPreferences.getBool(StorageKeys.rememberMeStatus);
  //   return status ?? false;
  // }

  // Future<void> saveUserName({required String userName}) async {
  //   sharedPreferences.setString(StorageKeys.saveUserName, userName);
  // }

  // Future<String?> getUserName() async {
  //   String? userName = sharedPreferences.getString(StorageKeys.saveUserName);
  //   return userName ?? "";
  // }

  // Future<void> saveTripResponse(
  //     {required GetTokenResponse getTokenResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.tripToken, json.encode(getTokenResponse.toJson()));
  // }

  // Future<GetTokenResponse?> getTripResponse() async {
  //   String? getTokenResponse =
  //       sharedPreferences.getString(StorageKeys.tripToken);
  //   return getTokenResponse == null
  //       ? null
  //       : GetTokenResponse.fromJson(jsonDecode(getTokenResponse));
  // }

  // Future<void> saveFirstName({required String firstName}) async {
  //   sharedPreferences.setString(StorageKeys.firstName, firstName);
  // }

  // Future<String?> getFirstName() async {
  //   String? firstName = sharedPreferences.getString(StorageKeys.firstName);
  //   return firstName ?? "";
  // }

  // Future<void> saveTransactionHistoryModel(
  //     {required GetTransactionHistoryResponse
  //         getTransactionHistoryResponse}) async {
  //   sharedPreferences.setString(StorageKeys.allTransactionHistoryModel,
  //       json.encode(getTransactionHistoryResponse.toJson()));
  // }

  // Future<GetTransactionHistoryResponse?> getTransactionHistoryModel() async {
  //   String? transactionHistoryResponse =
  //       sharedPreferences.getString(StorageKeys.allTransactionHistoryModel);
  //   return transactionHistoryResponse == null
  //       ? null
  //       : GetTransactionHistoryResponse.fromJson(
  //           jsonDecode(transactionHistoryResponse));
  // }

  // Future<void> saveDisputeCategoryResponse(
  //     {required DisputeCategoryResponse disputeCategoryResponse}) async {
  //   sharedPreferences.setString(StorageKeys.disputeCategory,
  //       json.encode(disputeCategoryResponse.toJson()));
  // }

  // Future<DisputeCategoryResponse?> getDisputeCategoryResponse() async {
  //   String? disputeCategoryResponse =
  //       sharedPreferences.getString(StorageKeys.disputeCategory);
  //   return disputeCategoryResponse == null
  //       ? null
  //       : DisputeCategoryResponse.fromJson(jsonDecode(disputeCategoryResponse));
  // }

  // Future<void> saveUserAccountDashboard(
  //     {required UserAccountResponse userAccountResponse}) async {
  //   sharedPreferences.setString(StorageKeys.accountDashboard,
  //       json.encode(userAccountResponse.toJson()));
  // }

  // Future<UserAccountResponse?> getUserAccountDashboard() async {
  //   String? userAccountResponse =
  //       sharedPreferences.getString(StorageKeys.accountDashboard);
  //   return userAccountResponse == null
  //       ? null
  //       : UserAccountResponse.fromJson(jsonDecode(userAccountResponse));
  // }

  // Future<void> saveGetBeneficiaryResponse(
  //     {required GetBeneficiaryResponse getBeneficiaryResponse}) async {
  //   sharedPreferences.setString(StorageKeys.beneficiaryResponse,
  //       json.encode(getBeneficiaryResponse.toJson()));
  // }

  // Future<GetBeneficiaryResponse?> getGetBeneficiaryResponse() async {
  //   String? getBeneficiaryResponse =
  //       sharedPreferences.getString(StorageKeys.beneficiaryResponse);
  //   return getBeneficiaryResponse == null
  //       ? null
  //       : GetBeneficiaryResponse.fromJson(jsonDecode(getBeneficiaryResponse));
  // }



  // Future<void> saveGetBeneficiaryBillsResponse(
  //     {required FetchBeneficiaryBillsResponse getBeneficiaryResponse}) async {
  //   sharedPreferences.setString(StorageKeys.beneficiaryBillsResponse,
  //       json.encode(getBeneficiaryResponse.toJson()));
  // }

  // Future<FetchBeneficiaryBillsResponse?> getGetBeneficiaryBillsResponse() async {
  //   String? getBeneficiaryResponse =
  //       sharedPreferences.getString(StorageKeys.beneficiaryBillsResponse);
  //   return getBeneficiaryResponse == null
  //       ? null
  //       : FetchBeneficiaryBillsResponse.fromJson(jsonDecode(getBeneficiaryResponse));
  // }

  // Future<void> saveEnairaAccountDashboard(
  //     {required EnairaBalanceResponse enairaBalanceResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.enaira, json.encode(enairaBalanceResponse.toJson()));
  // }

  // Future<EnairaBalanceResponse?> getBankAccountList() async {
  //   String? enairaBalanceResponse =
  //       sharedPreferences.getString(StorageKeys.enaira);
  //   return enairaBalanceResponse == null
  //       ? null
  //       : EnairaBalanceResponse.fromJson(jsonDecode(enairaBalanceResponse));
  // }

  // Future<void> saveBankAccountList(
  //     {required EnairaBalanceResponse enairaBalanceResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.enaira, json.encode(enairaBalanceResponse.toJson()));
  // }

  // Future<EnairaBalanceResponse?> getEnairaAccountDashboard() async {
  //   String? enairaBalanceResponse =
  //       sharedPreferences.getString(StorageKeys.enaira);
  //   return enairaBalanceResponse == null
  //       ? null
  //       : EnairaBalanceResponse.fromJson(jsonDecode(enairaBalanceResponse));
  // }

  // Future<void> saveDashboardAdvert(
  //     {required GetDashboardAdvertResponse getDashboardAdvertResponse}) async {
  //   sharedPreferences.setString(StorageKeys.dashboardAdvert,
  //       json.encode(getDashboardAdvertResponse.toJson()));
  // }

  // Future<GetDashboardAdvertResponse?> getDashboardAdvert() async {
  //   String? dashboardAdvertResponse =
  //       sharedPreferences.getString(StorageKeys.dashboardAdvert);
  //   return dashboardAdvertResponse == null
  //       ? null
  //       : GetDashboardAdvertResponse.fromJson(
  //           jsonDecode(dashboardAdvertResponse));
  // }



  //  Future<void> saveVideo(
  //     {required VideoResponse videoResponse}) async {
  //   sharedPreferences.setString(StorageKeys.video,
  //       json.encode(videoResponse.toJson()));
  // }

  // Future<VideoResponse?> getVideo() async {
  //   String? videoResponse =
  //       sharedPreferences.getString(StorageKeys.video);
  //   return videoResponse == null
  //       ? null
  //       : VideoResponse.fromJson(
  //           jsonDecode(videoResponse));
  // }


  // Future<void> saveFAQResponse({required GetFaqResponse getFaqResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.faq, json.encode(getFaqResponse.toJson()));
  // }

  // Future<GetFaqResponse?> getFAQResponse() async {
  //   String? getFaqResponse = sharedPreferences.getString(StorageKeys.faq);
  //   return getFaqResponse == null
  //       ? null
  //       : GetFaqResponse.fromJson(jsonDecode(getFaqResponse));
  // }

  // Future<void> saveSecurityQuestionsResponse(
  //     {required GetSecurityResponseModel getSecurityResponseModel}) async {
  //   sharedPreferences.setString(StorageKeys.securityQuestions,
  //       json.encode(getSecurityResponseModel.toJson()));
  // }

  // Future<GetSecurityResponseModel?> getSecurityQuestionsResponse() async {
  //   String? getSecurityResponseModel =
  //       sharedPreferences.getString(StorageKeys.securityQuestions);
  //   return getSecurityResponseModel == null
  //       ? null
  //       : GetSecurityResponseModel.fromJson(
  //           jsonDecode(getSecurityResponseModel));
  // }

  // Future<void> saveChequeRequestPricingResponse(
  //     {required GetChequeRequestPricingResponse
  //         getChequeRequestPricingResponse}) async {
  //   sharedPreferences.setString(StorageKeys.chequeRequestPricing,
  //       json.encode(getChequeRequestPricingResponse.toJson()));
  // }

  // Future<GetChequeRequestPricingResponse?>
  //     getChequeRequestPricingResponse() async {
  //   String? getChequeRequestPricingResponse =
  //       sharedPreferences.getString(StorageKeys.chequeRequestPricing);
  //   return getChequeRequestPricingResponse == null
  //       ? null
  //       : GetChequeRequestPricingResponse.fromJson(
  //           jsonDecode(getChequeRequestPricingResponse));
  // }

  // Future<void> saveAllBanksResponse(
  //     {required GetChequeRequestPricingResponse
  //         getChequeRequestPricingResponse}) async {
  //   sharedPreferences.setString(StorageKeys.chequeRequestPricing,
  //       json.encode(getChequeRequestPricingResponse.toJson()));
  // }

  // Future<GetChequeRequestPricingResponse?> getAllBanksResponse() async {
  //   String? getChequeRequestPricingResponse =
  //       sharedPreferences.getString(StorageKeys.chequeRequestPricing);
  //   return getChequeRequestPricingResponse == null
  //       ? null
  //       : GetChequeRequestPricingResponse.fromJson(
  //           jsonDecode(getChequeRequestPricingResponse));
  // }

  // Future<void> saveBranchesResponse(
  //     {required BranchesResponseModel branchesResponseModel}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.branches, json.encode(branchesResponseModel.toJson()));
  // }

  // Future<BranchesResponseModel?> getBranchesResponse() async {
  //   String? branchesResponseModel =
  //       sharedPreferences.getString(StorageKeys.branches);
  //   return branchesResponseModel == null
  //       ? null
  //       : BranchesResponseModel.fromJson(jsonDecode(branchesResponseModel));
  // }

  // Future<void> saveAllCardResponse(
  //     {required GetAllCardsResponse getAllCardsResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.allCards, json.encode(getAllCardsResponse.toJson()));
  // }

  // Future<void> saveAllVirtualCardResponse(
  //     {required GetAllVirtualCardResponse getAllCardsResponse}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.allVirtualCards, json.encode(getAllCardsResponse.toJson()));
  // }

  // Future<GetAllCardsResponse?> getAllCardsResponse() async {
  //   String? allCards = sharedPreferences.getString(StorageKeys.allCards);
  //   return allCards == null
  //       ? null
  //       : GetAllCardsResponse.fromJson(jsonDecode(allCards));
  // }

  // Future<GetAllVirtualCardResponse?> getAllVirtualCardsResponse() async {
  //   String? allCards = sharedPreferences.getString(StorageKeys.allVirtualCards);
  //   return allCards == null
  //       ? null
  //       : GetAllVirtualCardResponse.fromJson(jsonDecode(allCards));
  // }

  // Future<void> saveAllBankResponse({required GetBanks getBanks}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.allBanks, json.encode(getBanks.toJson()));
  // }

  // Future<GetBanks?> getAllBankResponse() async {
  //   String? allBanks = sharedPreferences.getString(StorageKeys.allBanks);
  //   return allBanks == null ? null : GetBanks.fromJson(jsonDecode(allBanks));
  // }

  // Future<void> saveWalletResponse(
  //     {required ThirdPartyWalletResponse fetchWallet}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.fetchWallet, json.encode(fetchWallet.toJson()));
  // }

  // Future<ThirdPartyWalletResponse?> fetchWalletResponse() async {
  //   String? wallet = sharedPreferences.getString(StorageKeys.fetchWallet);
  //   return wallet == null
  //       ? null
  //       : ThirdPartyWalletResponse.fromJson(jsonDecode(wallet));
  // }

  // Future<void> saveAllEBillBillers(
  //     {required EBillBillersResponseModel eBillBillersResponseModel}) async {
  //   sharedPreferences.setString(StorageKeys.eBillBillersResponseModel,
  //       json.encode(eBillBillersResponseModel.toJson()));
  // }

  // Future<EBillBillersResponseModel?> getAllEBillBillers() async {
  //   String? eBillBillersResponseModel =
  //       sharedPreferences.getString(StorageKeys.eBillBillersResponseModel);
  //   return eBillBillersResponseModel == null
  //       ? null
  //       : EBillBillersResponseModel.fromJson(
  //           jsonDecode(eBillBillersResponseModel));
  // }

  // Future<void> saveUserProfile(
  //     {required GetProfileResponse userProfile}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.userProfile, json.encode(userProfile.toJson()));
  // }

  // Future<GetProfileResponse?> getUserProfile() async {
  //   String? userProfile = sharedPreferences.getString(StorageKeys.userProfile);
  //   return userProfile == null
  //       ? null
  //       : GetProfileResponse.fromJson(jsonDecode(userProfile));
  // }

  // Future<int?> getActiveAccount() async {
  //   int? activeAccount = sharedPreferences.getInt(StorageKeys.activeAccount);
  //   return activeAccount ?? 0;
  // }

  // Future<void> saveActiveAccount({required int activeAccount}) async {
  //   sharedPreferences.setInt(StorageKeys.activeAccount, activeAccount);
  // }

  // Future<void> saveBillers(
  //     {required GetBillersResponseModel getBillersResponseModel}) async {
  //   sharedPreferences.setString(
  //       StorageKeys.billers, json.encode(getBillersResponseModel.toJson()));
  // }

  // Future<GetBillersResponseModel?> getBillers() async {
  //   String? getBillersResponseModel =
  //       sharedPreferences.getString(StorageKeys.billers);
  //   return getBillersResponseModel == null
  //       ? null
  //       : GetBillersResponseModel.fromJson(jsonDecode(getBillersResponseModel));
  // }

  // Future<void> saveRemitaBillers(
  //     {required GetRemitaBillersResponse getRemitaBillersResponse}) async {
  //   sharedPreferences.setString(StorageKeys.remitaBillers,
  //       json.encode(getRemitaBillersResponse.toJson()));
  // }

  // Future<GetRemitaBillersResponse?> getRemitaBillers() async {
  //   String? getRemitaBillersResponse =
  //       sharedPreferences.getString(StorageKeys.remitaBillers);
  //   return getRemitaBillersResponse == null
  //       ? null
  //       : GetRemitaBillersResponse.fromJson(
  //           jsonDecode(getRemitaBillersResponse));
  // }
}
