import 'package:field_force_app/http_client/dio_client.dart';

class CountryListRepository extends DioClient {
  final countryEndPoint = "Country/All";

  Future getCountryList() {
    return get(countryEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
