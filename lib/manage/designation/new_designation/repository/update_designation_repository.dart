import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateDesignationRepository extends DioClient {
  final updateDesignationEndPoint = "Designation/Update";

  Future updateDesignation({
    @required String? desName,
    @required String? desShortName,
    @required String? desDescription,
    @required int? desID,
  }) {
    var data = {
      "id": desID,
      "name": desName,
      "shortName": desShortName,
      "description": desDescription
    };
    return post(updateDesignationEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
