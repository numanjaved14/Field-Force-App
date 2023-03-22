import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateSpecializationRepository extends DioClient {
  final updateTeamEndPoint = "Doctor/Specialization/Update";

  Future updateSpecialization({
    @required String? specializationName,
    @required String? specializationDescription,
    @required int? specializationID,
  }) {
    var data = {
      "id": specializationID,
      "name": specializationName,
      "description": specializationDescription
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
