class TaskDoctorModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  TaskDoctorModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  TaskDoctorModel.fromJson(Map<String, dynamic> json) {
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
  String? pmdcnumber;
  int? specialization;
  int? rank;
  String? contact1;
  String? contact2;
  int? city;
  String? cityName;
  String? specializationName;
  String? rankName;

  Result(
      {this.id,
      this.name,
      this.pmdcnumber,
      this.specialization,
      this.rank,
      this.contact1,
      this.contact2,
      this.city,
      this.cityName,
      this.specializationName,
      this.rankName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pmdcnumber = json['pmdcnumber'];
    specialization = json['specialization'];
    rank = json['rank'];
    contact1 = json['contact1'];
    contact2 = json['contact2'];
    city = json['city'];
    cityName = json['cityName'];
    specializationName = json['specializationName'];
    rankName = json['rankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pmdcnumber'] = this.pmdcnumber;
    data['specialization'] = this.specialization;
    data['rank'] = this.rank;
    data['contact1'] = this.contact1;
    data['contact2'] = this.contact2;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['specializationName'] = this.specializationName;
    data['rankName'] = this.rankName;
    return data;
  }
}
