import 'package:field_force_app/http_client/dio_client.dart';

class EmploymentStatusListRepository extends DioClient {
  final employmentStatusEndPoint = "EmploymentStatus/All";

  Future getEmploymentStatusList() {
    return get(employmentStatusEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
