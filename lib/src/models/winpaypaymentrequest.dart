// To parse this JSON data, do
//
//     final winpayPaymentRequest = winpayPaymentRequestFromJson(jsonString);

import 'dart:convert';

WinpayPaymentRequest winpayPaymentRequestFromJson(String str) =>
    WinpayPaymentRequest.fromJson(json.decode(str));

String winpayPaymentRequestToJson(WinpayPaymentRequest data) =>
    json.encode(data.toJson());

class WinpayPaymentRequest {
  WinpayPaymentRequest({
    required this.userid,
    required this.amount,
    required this.channel,
    required this.hash,
  });

  int userid;
  int amount;
  String channel;
  String hash;

  factory WinpayPaymentRequest.fromJson(Map<String, dynamic> json) =>
      WinpayPaymentRequest(
        userid: json["userid"],
        amount: json["amount"],
        channel: json["channel"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "amount": amount,
        "channel": channel,
        "hash": hash,
      };
}
