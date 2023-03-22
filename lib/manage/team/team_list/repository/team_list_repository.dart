import 'package:field_force_app/http_client/dio_client.dart';

class TeamListRepository extends DioClient {
  final teamEndPoint = "Team/All";

  Future getTeamList({
    required String token,
  }) {
    return get(teamEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
