import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewOfficeLocationRepository extends DioClient {
  final newOfficeLocationEndPoint = "OfficeLocation/Add";

  Future addNewOfficeLocation({
    @required String? address,
    @required String? contact,
    @required int? cityId,
    @required bool? headOffice,
  }) {
    var data = {
      "id": 0,
      "address": address,
      "contact1": contact,
      "contact2": "",
      "email": "",
      "fax": "",
      "extensions": "",
      "cityId": cityId,
      "isHeadOffice": headOffice
    };
    return post(newOfficeLocationEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
