class OfficeLocationModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  OfficeLocationModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  OfficeLocationModel.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? contact1;
  String? contact2;
  String? email;
  String? fax;
  String? extensions;
  int? cityId;
  bool? isHeadOffice;

  Result(
      {this.id,
      this.address,
      this.contact1,
      this.contact2,
      this.email,
      this.fax,
      this.extensions,
      this.cityId,
      this.isHeadOffice});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    contact1 = json['contact1'];
    contact2 = json['contact2'];
    email = json['email'];
    fax = json['fax'];
    extensions = json['extensions'];
    cityId = json['cityId'];
    isHeadOffice = json['isHeadOffice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['contact1'] = this.contact1;
    data['contact2'] = this.contact2;
    data['email'] = this.email;
    data['fax'] = this.fax;
    data['extensions'] = this.extensions;
    data['cityId'] = this.cityId;
    data['isHeadOffice'] = this.isHeadOffice;
    return data;
  }
}
