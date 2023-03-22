import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewRankRepository extends DioClient {
  final newRankEndPoint = "Doctor/Rank/Add";

  Future addNewRank({
    @required String? rankName,
    @required String? rankDescription,
    @required String? token,
  }) {
    var data = {
      "id": 0,
      "name": rankName,
      "description": rankDescription,
      "active": true
    };
    return post(newRankEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
