import 'package:field_force_app/http_client/dio_client.dart';

class ProductListRepository extends DioClient {
  final productEndPoint = "Product/All";

  Future getProductList() {
    return get(productEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
