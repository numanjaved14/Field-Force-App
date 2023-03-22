import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateCityRepository extends DioClient {
  final updateCityEndPoint = "City/Update";

  Future updateCity({
    @required String? cityName,
    @required String? cityShortName,
    @required int? coutryID,
    @required int? cityID,
  }) {
    var data = {
      "id": cityID,
      "name": cityName,
      "shortName": cityShortName,
      "countryId": coutryID,
    };
    return post(updateCityEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
