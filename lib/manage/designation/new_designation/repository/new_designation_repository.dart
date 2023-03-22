import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewDesignationRepository extends DioClient {
  final newDesignationEndPoint = "Designation/Add";

  Future addNewDesignation({
    @required String? desName,
    @required String? desShortName,
    @required String? desDescription,
  }) {
    var data = {
      "id": 0,
      "name": desName,
      "shortName": desShortName,
      "description": desDescription
    };
    return post(newDesignationEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
