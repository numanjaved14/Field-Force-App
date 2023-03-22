class AuthModel {
  bool? status;
  String? message;
  String? tag;
  String? errorCode;
  List<Result>? result;
  bool? hasResult;

  AuthModel(
      {this.status,
      this.message,
      this.tag,
      this.errorCode,
      this.result,
      this.hasResult});

  AuthModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  RefreshToken? refreshToken;
  User? user;

  Result({this.accessToken, this.refreshToken, this.user});

  Result.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class RefreshToken {
  String? tokenString;
  String? expireAt;

  RefreshToken({this.tokenString, this.expireAt});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    tokenString = json['tokenString'];
    expireAt = json['expireAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenString'] = this.tokenString;
    data['expireAt'] = this.expireAt;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? designation;

  User({this.id, this.firstName, this.lastName, this.designation});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['designation'] = this.designation;
    return data;
  }
}
