import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class UpdateProductRepository extends DioClient {
  final updateProductEndPoint = "Product/Update";

  Future updateProduct({
    @required String? productName,
    @required String? productDescription,
    @required int? productID,
    @required bool? activeStatus,
  }) {
    var data = {
      "id": productID,
      "name": productName,
      "description": productDescription,
      "active": activeStatus,
    };
    return post(updateProductEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
