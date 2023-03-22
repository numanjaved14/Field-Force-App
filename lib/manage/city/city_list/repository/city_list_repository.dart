import 'package:field_force_app/http_client/dio_client.dart';

class CityListRepository extends DioClient {
  final cityEndPoint = "City/All";

  Future getCityList({required int countryID}) {
    return get('$cityEndPoint?P_COUNTRY_ID=$countryID');
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
