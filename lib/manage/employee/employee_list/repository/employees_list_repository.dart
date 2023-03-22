import 'package:field_force_app/http_client/dio_client.dart';

class EmployeeListRepository extends DioClient {
  final employeeEndPoint = "Employee/All";

  Future getEmployeeList() {
    return get(employeeEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
