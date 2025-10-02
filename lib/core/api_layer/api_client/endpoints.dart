class Endpoints {
  static const String baseUrl = 'https://flower.elevateegy.com/api';
  static const String apply = '/v1/drivers/apply';
  static const String forgetPassword = '/v1/drivers/forgotPassword';
  static const String verifyResetCode = '/v1/drivers/verifyResetCode';
  static const String resetPassword = '/v1/drivers/resetPassword';
  static const String login = '/v1/drivers/signin';
  static const String getLoggedDriver = '/v1/drivers/profile-data';
  static const String editProfile = "/v1/drivers/editProfile";
  static const String uploadPhoto = 'v1/auth/upload-photo';
  static const String pendingDriverOrdersRoute = '/v1/orders/pending-orders';
  static const String startOrder = '/v1/orders/start';
  static const String updateOrder = "/v1/orders/state";
}
