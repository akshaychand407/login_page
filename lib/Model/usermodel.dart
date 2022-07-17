class UserModel {
  int? code;
  String? message;
  Data? data;

  UserModel({this.code, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? token;
  String? tokenExpires;
  String? firstName;
  String? lastName;
  String? contactNo;
  String? empCode;
  String? role;
  List<VerticalArray>? verticalArray;

  Data(
      {this.id,
      this.token,
      this.tokenExpires,
      this.firstName,
      this.lastName,
      this.contactNo,
      this.empCode,
      this.role,
      this.verticalArray});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    tokenExpires = json['tokenExpires'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNo = json['contactNo'];
    empCode = json['empCode'];
    role = json['role'];
    if (json['verticalArray'] != null) {
      verticalArray = <VerticalArray>[];
      json['verticalArray'].forEach((v) {
        verticalArray!.add(VerticalArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['tokenExpires'] = this.tokenExpires;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNo'] = this.contactNo;
    data['empCode'] = this.empCode;
    data['role'] = this.role;
    if (this.verticalArray != null) {
      data['verticalArray'] =
          this.verticalArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VerticalArray {
  String? verticalId;
  String? verticalName;
  String? priceTypeId;
  String? priceTypeName;

  VerticalArray(
      {this.verticalId,
      this.verticalName,
      this.priceTypeId,
      this.priceTypeName});

  VerticalArray.fromJson(Map<String, dynamic> json) {
    verticalId = json['verticalId'];
    verticalName = json['verticalName'];
    priceTypeId = json['priceTypeId'];
    priceTypeName = json['priceTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['verticalId'] = this.verticalId;
    data['verticalName'] = this.verticalName;
    data['priceTypeId'] = this.priceTypeId;
    data['priceTypeName'] = this.priceTypeName;
    return data;
  }
}