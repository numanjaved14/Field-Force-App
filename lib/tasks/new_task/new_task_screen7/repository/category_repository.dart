import 'package:field_force_app/http_client/dio_client.dart';

class TaskCategoryRepository extends DioClient {
  final categoryEndPoint = "Task/Priority/All";

  Future getTaskCategory() {
    return get(categoryEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
