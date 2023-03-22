import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';

class NewDoctorRepository extends DioClient {
  final newDoctorEndPoint = "Doctor/Add";

  Future addNewDoctor({
    @required String? doctorName,
    @required String? contact1,
    @required String? contact2,
    @required String? pmdcNumber,
    @required int? specializationID,
    @required String? specializationName,
    @required int? rankID,
    @required String? rankName,
    @required int? cityID,
    @required String? cityName,
    @required String? token,
  }) {
    var data = {
      "id": 0,
      "name": doctorName,
      "contact1": contact1,
      "contact2": contact2,
      "pmdcnumber": pmdcNumber,
      "specialization": specializationID,
      "specializationName": specializationName,
      "rank": rankID,
      "rankName": rankName,
      "city": cityID,
      "cityName": cityName,
    };
    print('$data');
    return post(newDoctorEndPoint, data: data);
  }

  @override
  void onError(error) {}

  @override
  void onRequestTimeout() {}

  @override
  void onResponseTimeout() {}
}
