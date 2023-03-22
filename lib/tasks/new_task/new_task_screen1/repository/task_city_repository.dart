import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/material.dart';

class TaskCityRepository extends DioClient {
  final taskCityEndPoint = "Task/City/All";

  Future getTaskCity({
    @required int? countryId,
  }) {
    return get("$taskCityEndPoint?P_COUNTRY_ID=1");
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
