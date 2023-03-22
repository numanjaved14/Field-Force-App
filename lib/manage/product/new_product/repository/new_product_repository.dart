import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewProductRepository extends DioClient {
  final newProductEndPoint = "Product/Add";

  Future addNewProduct({
    @required String? productName,
    @required String? productDescription,
  }) {
    var data = {
      "id": 0,
      "name": productName,
      "description": productDescription,
      "active": true
    };
    return post(newProductEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
