import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateDepartmentRepository extends DioClient {
  final updateTeamEndPoint = "Department/Update";

  Future updateDepartment({
    @required String? depName,
    @required String? depDescription,
    @required int? depID,
    @required bool? activeStatus,
  }) {
    var data = {
      "id": depID,
      "name": depName,
      "description": depDescription,
      "active": activeStatus,
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
