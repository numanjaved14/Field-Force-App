import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/material.dart';

class TaskDoctorRepository extends DioClient {
  final taskDoctorEndPoint = "Task/Doctor/All";

  Future getTaskDoctor({
    @required int? cityID,
  }) {
    return get("$taskDoctorEndPoint?P_CITY_ID=$cityID");
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
