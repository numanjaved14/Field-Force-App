import 'package:field_force_app/http_client/dio_client.dart';

class RankListRepository extends DioClient {
  final rankEndPoint = "Doctor/Rank/All";

  Future getRankList({
    required String token,
  }) {
    return get(rankEndPoint);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
