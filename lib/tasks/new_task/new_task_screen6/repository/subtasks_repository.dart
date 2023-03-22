import 'package:field_force_app/http_client/dio_client.dart';

class TaskSubTasksRepository extends DioClient {
  final subTasksEndPoint = "Task/SubTask/All";

  Future getTaskSubTasks() {
    return get(subTasksEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
