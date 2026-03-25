class ApiRoutes {
  static const registerLocation = "/location/register";
  static const logOut = "/auth/Logout";
static const fetchItemsNearme = "/item/nearby/{deviceId}?page={page}";

static const fetchItemsbyId = "/item/{deviceId}/{Id}";
static const createAlerts = "/alerts";
static const fetchAlertLists ="alerts?deviceId={deviceId}";
static const searchAlertCategories = "/alerts/search-keywords";
static const alertCategoriesList = "/categories";
static const alertSubCategoriesList = "/categories/tree?categoryId={categoryId}";
static const alertSearchPredictionList = "/categories/search";
  static const globalSearch = "/item/{deviceId}/search";






static const register = "/auth/register";
static const verifyEmail = "/auth/verify-email";
static const login = "/auth/login";
static const resendCode = "/auth/resend-code";
static const forgotPassword = "/auth/forgot-password";
static const resetPassword = "/auth/reset-password";



//Base Url
static const baseUrl = "https://api.giftpose.com/api";


}


