class ApiRoutes {
  static const logIn = "/auth/login";
  static const logOut = "/auth/Logout";
  static const register = "/auth/register";
  static const  sendVerification= "/auth/send-verification";
  static const validateOtp = "/auth/verify";
static const getUser  = "/Auth/me";
static const createProfile = "/users/basic-profile";
static const fetchWallet = "/wallets";
static const fetchDefaultWallet = "/wallets/default";
static const fetchWalletTransactions = "/wallets/transactions";

//products
static const fetchProducts = "/products";
static const searchProducts = "/products/search";
static const fetchProductOnSale = "/products/on-sale";
static const fetchProductInstallments = "/products/{productId}/installments";
static const fetchProductInstallmentPaymentBreakdown = "/products/{productId}/installments/{installmentType}/{duration}";
static const createDeliveryAddressForGuest = "/delivery-addresses";
static const initiatePayment = "/orders/{orderId}/payment/initiate";
static const createOrder = "/orders";

static const validateDeliveryAddress = "/delivery-addresses/validate";
static const getUsersDeliveryAddress = "/delivery-addresses?page=1&limit=10";
static const getUsersOrders = "/orders?page=1&limit={limit}";
static const getUsersOrdersPaymentHistory = "/orders/{id}/payment/history";








 


//Base Url
static const baseUrl = "https://dev.getqost.com/api/v1";



}


