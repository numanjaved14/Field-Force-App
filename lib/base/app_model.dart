//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable()
class AppModel {
  final bool status;
  final String message;
  final String tag;
  final String errorCode;
  final bool hasResult;

  AppModel(
      {this.status = false,
      this.message = "",
      this.tag = "",
      this.errorCode = "",
      this.hasResult = false});

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
        status: json["status"],
        message: json["message"],
        tag: json["tag"],
        errorCode: json["errorCode"],
        hasResult: json["hasResult"]);
  }
}
