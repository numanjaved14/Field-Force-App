import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewDepartmentRepository extends DioClient {
  final newTeamEndPoint = "Department/Add";

  Future addNewDepartment({
    @required String? depName,
    @required String? depDescription,
  }) {
    var data = {
      "id": 0,
      "name": depName,
      "description": depDescription,
      "active": true
    };
    return post(newTeamEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
