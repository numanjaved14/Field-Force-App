import 'package:field_force_app/http_client/dio_client.dart';

class TaskProductRepository extends DioClient {
  final productEndPoint = "Task/Product/All";

  Future getTaskProduct() {
    return get(productEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
