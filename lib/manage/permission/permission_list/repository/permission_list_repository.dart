import 'package:field_force_app/http_client/dio_client.dart';

class PermissionListRepository extends DioClient {
  final permissionEndPoint = "Permission/All";

  Future getPermissionList() {
    return get(permissionEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
