import 'package:field_force_app/base/models/role_model.dart';
import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewRoleRepository extends DioClient {
  final newRoleEndPoint = "Role/Add";

  Future addNewRole({
    @required String? roleName,
    @required String? roleDescription,
    @required List<RolePermissions>? rolePermissionList,
  }) {
    var data = {
      "id": 0,
      "name": roleName,
      "description": roleDescription,
      "active": true,
      "rolePermissions": rolePermissionList
    };
    return post(newRoleEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
