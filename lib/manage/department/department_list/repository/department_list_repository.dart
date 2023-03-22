import 'package:field_force_app/http_client/dio_client.dart';

class DepartmentListRepository extends DioClient {
  final depEndPoint = "Department/All";

  Future getDepartmentList() {
    return get(depEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
