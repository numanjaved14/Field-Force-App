import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateEmploymentStatusRepository extends DioClient {
  final updateEmploymentStatusEndPoint = "EmploymentStatus/Update";

  Future updateEmploymentStatus({
    @required String? employmentStatusName,
    @required String? employmentStatusDescription,
    @required int? employmentStatusID,
    @required bool? activeStatus,
  }) {
    var data = {
      "id": employmentStatusID,
      "name": employmentStatusName,
      "description": employmentStatusDescription,
      "active": activeStatus,
    };
    return post(updateEmploymentStatusEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
