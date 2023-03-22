class PermissionModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  PermissionModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  PermissionModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  List<EmployeeRoles>? employeeRoles;
  List<EmployeePermissions>? employeePermissions;

  Result({this.employeeId, this.employeeRoles, this.employeePermissions});

  Result.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    if (json['employeeRoles'] != null) {
      employeeRoles = <EmployeeRoles>[];
      json['employeeRoles'].forEach((v) {
        employeeRoles!.add(new EmployeeRoles.fromJson(v));
      });
    }
    if (json['employeePermissions'] != null) {
      employeePermissions = <EmployeePermissions>[];
      json['employeePermissions'].forEach((v) {
        employeePermissions!.add(new EmployeePermissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    if (this.employeeRoles != null) {
      data['employeeRoles'] =
          this.employeeRoles!.map((v) => v.toJson()).toList();
    }
    if (this.employeePermissions != null) {
      data['employeePermissions'] =
          this.employeePermissions!.map((v) => v.toJson()).toList();
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

class EmployeePermissions {
  int? roleId;
  String? roleName;
  int? permissionId;
  String? permissionName;
  String? permissionDescription;

  EmployeePermissions(
      {this.roleId,
      this.roleName,
      this.permissionId,
      this.permissionName,
      this.permissionDescription});

  EmployeePermissions.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    roleName = json['roleName'];
    permissionId = json['permissionId'];
    permissionName = json['permissionName'];
    permissionDescription = json['permissionDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['permissionId'] = this.permissionId;
    data['permissionName'] = this.permissionName;
    data['permissionDescription'] = this.permissionDescription;
    return data;
  }
}
