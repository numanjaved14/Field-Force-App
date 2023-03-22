import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateTeamRepository extends DioClient {
  final updateTeamEndPoint = "Team/Update";

  Future updateTeam({
    @required String? teamName,
    @required String? teamDescription,
    @required int? teamID,
    @required bool? activeStatus,
  }) {
    var data = {
      "id": teamID,
      "name": teamName,
      "description": teamDescription,
      "active": activeStatus,
    };
    return post(updateTeamEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
