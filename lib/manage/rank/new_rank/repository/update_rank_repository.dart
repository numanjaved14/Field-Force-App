import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateRankRepository extends DioClient {
  final updateRankEndPoint = "Doctor/Rank/Update";

  Future updateRank({
    @required String? rankName,
    @required String? rankDescription,
    @required int? rankID,
  }) {
    var data = {
      "id": rankID,
      "name": rankName,
      "description": rankDescription,
    };
    return post(updateRankEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
