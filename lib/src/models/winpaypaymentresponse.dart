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
    required this.data,
  });

  bool success;
  WinpayPaymentResponseData data;

  factory WinpayPaymentResponse.fromJson(Map<String, dynamic> json) =>
      WinpayPaymentResponse(
        success: json["success"],
        data: WinpayPaymentResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class WinpayPaymentResponseData {
  WinpayPaymentResponseData({
    required this.rc,
    required this.rd,
    required this.requestTime,
    required this.data,
    required this.responseTime,
  });

  String rc;
  String rd;
  DateTime requestTime;
  DataData data;
  DateTime responseTime;

  factory WinpayPaymentResponseData.fromJson(Map<String, dynamic> json) =>
      WinpayPaymentResponseData(
        rc: json["rc"],
        rd: json["rd"],
        requestTime: DateTime.parse(json["request_time"]),
        data: DataData.fromJson(json["data"]),
        responseTime: DateTime.parse(json["response_time"]),
      );

  Map<String, dynamic> toJson() => {
        "rc": rc,
        "rd": rd,
        "request_time": requestTime.toIso8601String(),
        "data": data.toJson(),
        "response_time": responseTime.toIso8601String(),
      };
}

class DataData {
  DataData({
    required this.reffId,
    required this.paymentCode,
    required this.orderId,
    required this.requestKey,
    required this.urlListener,
    required this.paymentMethod,
    required this.paymentMethodCode,
    required this.feeAdmin,
    required this.totalAmount,
    required this.spiStatusUrl,
  });

  String reffId;
  String paymentCode;
  String orderId;
  String requestKey;
  String urlListener;
  String paymentMethod;
  String paymentMethodCode;
  int feeAdmin;
  int totalAmount;
  String spiStatusUrl;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        reffId: json["reff_id"],
        paymentCode: json["payment_code"],
        orderId: json["order_id"],
        requestKey: json["request_key"],
        urlListener: json["url_listener"],
        paymentMethod: json["payment_method"],
        paymentMethodCode: json["payment_method_code"],
        feeAdmin: json["fee_admin"],
        totalAmount: json["total_amount"],
        spiStatusUrl: json["spi_status_url"],
      );

  Map<String, dynamic> toJson() => {
        "reff_id": reffId,
        "payment_code": paymentCode,
        "order_id": orderId,
        "request_key": requestKey,
        "url_listener": urlListener,
        "payment_method": paymentMethod,
        "payment_method_code": paymentMethodCode,
        "fee_admin": feeAdmin,
        "total_amount": totalAmount,
        "spi_status_url": spiStatusUrl,
      };
}
