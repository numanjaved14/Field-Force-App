import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewEmploymentStatusRepository extends DioClient {
  final newEmploymentStatusEndPoint = "EmploymentStatus/Add";

  Future addNewEmploymentStatus({
    @required String? employmentStatusName,
    @required String? employmentStatusDescription,
  }) {
    var data = {
      "id": 0,
      "name": employmentStatusName,
      "description": employmentStatusDescription,
      "active": true
    };
    return post(newEmploymentStatusEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
