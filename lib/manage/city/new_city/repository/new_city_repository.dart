import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewCityRepository extends DioClient {
  final newCityEndPoint = "City/Add";

  Future addNewCity({
    @required String? cityName,
    @required String? cityShortName,
    @required int? coutryID,
  }) {
    var data = {
      "id": 0,
      "name": cityName,
      "shortName": cityShortName,
      "countryId": coutryID,
    };
    return post(newCityEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
