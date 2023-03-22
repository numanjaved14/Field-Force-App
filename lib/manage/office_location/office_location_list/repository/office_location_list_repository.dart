import 'package:field_force_app/http_client/dio_client.dart';

class OfficeLocationListRepository extends DioClient {
  final officeLocationEndPoint = "OfficeLocation/All";

  Future getOfficeLocationList() {
    return get(officeLocationEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
