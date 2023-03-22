import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/material.dart';

class TaskAsigneeRepository extends DioClient {
  final asigneeEndPoint = "Task/Employee/SubOrdinates";

  Future getTaskAsignee({
    @required int? empId,
  }) {
    return get("$asigneeEndPoint?P_EMPLOYEE_ID=$empId");
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
