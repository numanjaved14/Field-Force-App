import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewTeamRepository extends DioClient {
  final newTeamEndPoint = "Team/Add";

  Future addNewTeam({
    @required String? teamName,
    @required String? teamDescription,
    @required String? token,
  }) {
    var data = {
      "id": 0,
      "name": teamName,
      "description": teamDescription,
      "active": true
    };
    return post(newTeamEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
