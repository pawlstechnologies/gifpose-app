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













//Base Url
static const baseUrl = "https://api.giftpose.com/api";



}


