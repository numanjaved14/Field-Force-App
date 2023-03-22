import 'package:field_force_app/http_client/dio_client.dart';

class PermissionsRepository extends DioClient {
  final permissionEndPoint = "Employee/Permissions?P_EMPLOYEE_ID=";

  Future getPermissions({
    required String employeeId,
    required String token,
  }) {
    return get('$permissionEndPoint$employeeId');
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
