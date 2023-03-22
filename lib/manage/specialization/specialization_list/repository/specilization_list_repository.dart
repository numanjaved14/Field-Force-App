import 'package:field_force_app/http_client/dio_client.dart';

class SpecilizationListRepository extends DioClient {
  final specilizationEndPoint = "Doctor/Specialization/All";

  Future getSpecilizationList() {
    return get(specilizationEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
