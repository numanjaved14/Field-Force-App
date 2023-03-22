import 'package:field_force_app/http_client/dio_client.dart';

class TaskListRepository extends DioClient {
  final taskEndPoint = "Task/GetEmployeeTask";

  Future getTaskList({required int empId}) {
    var data = {
      "filter": {
        "taskType": 0,
        "taskPriority": 0,
        "taskStatus": 0,
        "taskAssignee": 0
      },
      "pageNumber": 1,
      "pagseSize": 10,
      "employeeId": empId,
    };

    return post(taskEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
