import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateOfficeLocationRepository extends DioClient {
  final updateOfficeLocationEndPoint = "OfficeLocation/Update";

  Future updateOfficeLocation({
    @required String? address,
    @required String? contact,
    @required int? cityId,
    @required int? id,
    @required bool? headOffice,
  }) {
    var data = {
      "id": id,
      "address": address,
      "contact1": contact,
      "contact2": "",
      "email": "",
      "fax": "",
      "extensions": "",
      "cityId": cityId,
      "isHeadOffice": headOffice
    };
    return post(updateOfficeLocationEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
