import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/material.dart';

class TaskHospitalLocationRepository extends DioClient {
  final hospitalLocationEndPoint = "Task/PracticeLocation/All";

  Future getTaskPracticeLoc({
    @required int? cityID,
  }) {
    //TODO: Change cityId
    return get("$hospitalLocationEndPoint?P_CITY_ID=1");
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
