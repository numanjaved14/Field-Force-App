import 'package:field_force_app/http_client/dio_client.dart';

class RoleListRepository extends DioClient {
  final roleEndPoint = "Role/All";

  Future getRoleList() {
    return get(roleEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
