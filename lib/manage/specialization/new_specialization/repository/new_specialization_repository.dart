import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewSpecializationRepository extends DioClient {
  final newSpecializationEndPoint = "Doctor/Specialization/Add";

  Future addNewSpecialization({
    @required String? specializationName,
    @required String? specializationDescription,
  }) {
    var data = {
      "id": 0,
      "name": specializationName,
      "description": specializationDescription
    };
    return post(newSpecializationEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
