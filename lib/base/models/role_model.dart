class RoleModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  RoleModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  RoleModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  bool? active;
  List<RolePermissions>? rolePermissions;

  Result(
      {this.id,
      this.name,
      this.description,
      this.active,
      this.rolePermissions});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    if (json['rolePermissions'] != null) {
      rolePermissions = <RolePermissions>[];
      json['rolePermissions'].forEach((v) {
        rolePermissions!.add(new RolePermissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['active'] = this.active;
    if (this.rolePermissions != null) {
      data['rolePermissions'] =
          this.rolePermissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RolePermissions {
  int? roleId;
  String? roleName;
  int? permissionId;
  String? permissionName;
  String? permissionDescription;

  RolePermissions(
      {this.roleId,
      this.roleName,
      this.permissionId,
      this.permissionName,
      this.permissionDescription});

  RolePermissions.fromJson(Map<String, dynamic> json) {
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
