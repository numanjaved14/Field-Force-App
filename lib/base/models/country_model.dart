class CountryModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  CountryModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tag = json['tag'];
    errorCode = json['errorCode'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    hasResult = json['hasResult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['tag'] = this.tag;
    data['errorCode'] = this.errorCode;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['hasResult'] = this.hasResult;
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? shortName;
  String? callingCode;

  Result({this.id, this.name, this.shortName, this.callingCode});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    callingCode = json['callingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['callingCode'] = this.callingCode;
    return data;
  }
}
