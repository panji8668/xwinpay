// To parse this JSON data, do
//
//     final winpayPaymentResponse = winpayPaymentResponseFromJson(jsonString);

import 'dart:convert';

WinpayPaymentResponse winpayPaymentResponseFromJson(String str) =>
    WinpayPaymentResponse.fromJson(json.decode(str));

String winpayPaymentResponseToJson(WinpayPaymentResponse data) =>
    json.encode(data.toJson());

class WinpayPaymentResponse {
  WinpayPaymentResponse({
    required this.success,
    this.data,
  });

  bool success;
  List<WinPaymentData>? data;

  factory WinpayPaymentResponse.fromJson(Map<String, dynamic> json) =>
      WinpayPaymentResponse(
        success: json["success"],
        data: List<WinPaymentData>.from(json["data"].map((x) => WinPaymentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WinPaymentData {
  WinPaymentData({
    required this.id,
    required this.userid,
    required this.reffid,
    required this.paymentcode,
    required this.orderid,
    required this.paymentMethod,
    required this.paymentMethodCode,
    required this.feeAdmin,
    required this.totalAmount,
    required this.status,
    required this.url,
    required this.msg,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userid;
  String reffid;
  String paymentcode;
  String orderid;
  String paymentMethod;
  String paymentMethodCode;
  int feeAdmin;
  int totalAmount;
  int status;
  String url;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;

  factory WinPaymentData.fromJson(Map<String, dynamic> json) => WinPaymentData(
        id: json["id"],
        userid: json["userid"],
        reffid: json["reffid"],
        paymentcode: json["paymentcode"],
        orderid: json["orderid"],
        paymentMethod: json["payment_method"],
        paymentMethodCode: json["payment_method_code"],
        feeAdmin: json["fee_admin"],
        totalAmount: json["total_amount"],
        status: json["status"],
        url: json["url"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "reffid": reffid,
        "paymentcode": paymentcode,
        "orderid": orderid,
        "payment_method": paymentMethod,
        "payment_method_code": paymentMethodCode,
        "fee_admin": feeAdmin,
        "total_amount": totalAmount,
        "status": status,
        "url": url,
        "msg": msg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
