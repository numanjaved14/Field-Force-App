import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

import '../../../../base/models/role_model.dart';

class UpdateRoleRepository extends DioClient {
  final updateTeamEndPoint = "Role/Update";

  Future updateRole({
    @required int? roleID,
    @required String? roleName,
    @required String? roleDescription,
    @required List<RolePermissions>? rolePermissionList,
  }) {
    var data = {
      "id": roleID,
      "name": roleName,
      "description": roleDescription,
      "active": true,
      "rolePermissions": rolePermissionList
    };
    return post(updateTeamEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
