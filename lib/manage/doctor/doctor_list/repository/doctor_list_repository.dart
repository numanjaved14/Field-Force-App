import 'package:field_force_app/http_client/dio_client.dart';

class DoctorListRepository extends DioClient {
  final doctorEndPoint = "Doctor/All";

  Future getDoctorList({
    required String token,
    required int cityID,
  }) {
    return get("$doctorEndPoint?P_CITY_ID=$cityID");
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
