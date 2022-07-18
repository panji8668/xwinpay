// To parse this JSON data, do
//
//     final winpayLayananResponse = winpayLayananResponseFromJson(jsonString);

import 'dart:convert';

WinpayLayananResponse winpayLayananResponseFromJson(String str) =>
    WinpayLayananResponse.fromJson(json.decode(str));

String winpayLayananResponseToJson(WinpayLayananResponse data) =>
    json.encode(data.toJson());

class WinpayLayananResponse {
  WinpayLayananResponse({
    required this.success,
    required this.layanan,
  });

  bool success;
  Layanan layanan;

  factory WinpayLayananResponse.fromJson(Map<String, dynamic> json) =>
      WinpayLayananResponse(
        success: json["success"],
        layanan: Layanan.fromJson(json["layanan"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "layanan": layanan.toJson(),
      };
}

class Layanan {
  Layanan({
    required this.modernStore,
    required this.virtualAccount,
    required this.qris,
  });

  List<ProdukWinpay> modernStore;
  List<ProdukWinpay> virtualAccount;
  List<ProdukWinpay> qris;

  factory Layanan.fromJson(Map<String, dynamic> json) => Layanan(
        modernStore: List<ProdukWinpay>.from(
            json["modern store"].map((x) => ProdukWinpay.fromJson(x))),
        virtualAccount: List<ProdukWinpay>.from(
            json["virtual account"].map((x) => ProdukWinpay.fromJson(x))),
        qris: List<ProdukWinpay>.from(
            json["qris"].map((x) => ProdukWinpay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "modern store": List<dynamic>.from(modernStore.map((x) => x.toJson())),
        "virtual account":
            List<dynamic>.from(virtualAccount.map((x) => x.toJson())),
        "qris": List<dynamic>.from(qris.map((x) => x.toJson())),
      };
}

class ProdukWinpay {
  ProdukWinpay({
    required this.paymentCode,
    required this.paymentName,
    required this.paymentDescription,
    required this.paymentLogo,
    required this.paymentUrl,
    required this.paymentUrlV2,
    required this.isDirect,
  });

  String paymentCode;
  String paymentName;
  String paymentDescription;
  String paymentLogo;
  String paymentUrl;
  String paymentUrlV2;
  bool isDirect;

  factory ProdukWinpay.fromJson(Map<String, dynamic> json) => ProdukWinpay(
        paymentCode: json["payment_code"],
        paymentName: json["payment_name"],
        paymentDescription: json["payment_description"],
        paymentLogo: json["payment_logo"],
        paymentUrl: json["payment_url"],
        paymentUrlV2: json["payment_url_v2"],
        isDirect: json["is_direct"],
      );

  Map<String, dynamic> toJson() => {
        "payment_code": paymentCode,
        "payment_name": paymentName,
        "payment_description": paymentDescription,
        "payment_logo": paymentLogo,
        "payment_url": paymentUrl,
        "payment_url_v2": paymentUrlV2,
        "is_direct": isDirect,
      };
}
