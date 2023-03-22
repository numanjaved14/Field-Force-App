
abstract class BaseHttpClient {
  // Response timeout
  void onResponseTimeout();
  // Request timeout
  void onRequestTimeout();
  // On any error
  void onError(dynamic error);
  // on Success. [Optional]
  void onSuccess(){}
}