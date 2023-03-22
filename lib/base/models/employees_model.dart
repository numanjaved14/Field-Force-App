class EmployeesModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  EmployeesModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  int? gender;
  String? genderName;
  String? nic;
  String? passport;
  String? address;
  int? city;
  String? cityName;
  String? personalContact1;
  String? personalContact2;
  String? personalEmail;
  int? designation;
  String? designationName;
  String? dateOfJoining;
  String? dateOfBirth;
  int? jobLocation;
  String? jobLocationName;
  String? officialEmail;
  String? officialContact1;
  String? officialContact2;
  int? department;
  String? departmentName;
  int? reportsTo;
  String? reportsToName;
  int? team;
  String? teamName;
  int? employmentStatus;
  String? employmentStatusName;
  String? password;
  List<EmployeeRoles>? employeeRoles;

  Result(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.genderName,
      this.nic,
      this.passport,
      this.address,
      this.city,
      this.cityName,
      this.personalContact1,
      this.personalContact2,
      this.personalEmail,
      this.designation,
      this.designationName,
      this.dateOfJoining,
      this.dateOfBirth,
      this.jobLocation,
      this.jobLocationName,
      this.officialEmail,
      this.officialContact1,
      this.officialContact2,
      this.department,
      this.departmentName,
      this.reportsTo,
      this.reportsToName,
      this.team,
      this.teamName,
      this.employmentStatus,
      this.employmentStatusName,
      this.password,
      this.employeeRoles});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    genderName = json['genderName'];
    nic = json['nic'];
    passport = json['passport'];
    address = json['address'];
    city = json['city'];
    cityName = json['cityName'];
    personalContact1 = json['personalContact1'];
    personalContact2 = json['personalContact2'];
    personalEmail = json['personalEmail'];
    designation = json['designation'];
    designationName = json['designationName'];
    dateOfJoining = json['dateOfJoining'];
    dateOfBirth = json['dateOfBirth'];
    jobLocation = json['jobLocation'];
    jobLocationName = json['jobLocationName'];
    officialEmail = json['officialEmail'];
    officialContact1 = json['officialContact1'];
    officialContact2 = json['officialContact2'];
    department = json['department'];
    departmentName = json['departmentName'];
    reportsTo = json['reportsTo'];
    reportsToName = json['reportsToName'];
    team = json['team'];
    teamName = json['teamName'];
    employmentStatus = json['employmentStatus'];
    employmentStatusName = json['employmentStatusName'];
    password = json['password'];
    if (json['employeeRoles'] != null) {
      employeeRoles = <EmployeeRoles>[];
      json['employeeRoles'].forEach((v) {
        employeeRoles!.add(new EmployeeRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['genderName'] = this.genderName;
    data['nic'] = this.nic;
    data['passport'] = this.passport;
    data['address'] = this.address;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['personalContact1'] = this.personalContact1;
    data['personalContact2'] = this.personalContact2;
    data['personalEmail'] = this.personalEmail;
    data['designation'] = this.designation;
    data['designationName'] = this.designationName;
    data['dateOfJoining'] = this.dateOfJoining;
    data['dateOfBirth'] = this.dateOfBirth;
    data['jobLocation'] = this.jobLocation;
    data['jobLocationName'] = this.jobLocationName;
    data['officialEmail'] = this.officialEmail;
    data['officialContact1'] = this.officialContact1;
    data['officialContact2'] = this.officialContact2;
    data['department'] = this.department;
    data['departmentName'] = this.departmentName;
    data['reportsTo'] = this.reportsTo;
    data['reportsToName'] = this.reportsToName;
    data['team'] = this.team;
    data['teamName'] = this.teamName;
    data['employmentStatus'] = this.employmentStatus;
    data['employmentStatusName'] = this.employmentStatusName;
    data['password'] = this.password;
    if (this.employeeRoles != null) {
      data['employeeRoles'] =
          this.employeeRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeRoles {
  int? employeeId;
  int? roleId;

  EmployeeRoles({this.employeeId, this.roleId});

  EmployeeRoles.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['roleId'] = this.roleId;
    return data;
  }
}
