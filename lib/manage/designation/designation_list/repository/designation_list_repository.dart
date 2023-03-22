import 'package:field_force_app/http_client/dio_client.dart';

class DesignationListRepository extends DioClient {
  final designationEndPoint = "Designation/All";

  Future getDesignationList() {
    return get(designationEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
