import 'package:xwinpay/src/models/winpaylayananresp.dart';
import 'package:xwinpay/src/models/winpaypaymentrequest.dart';
import 'package:xwinpay/src/models/winpaypaymentresponse.dart';
import 'package:xwinpay/src/services/baseservice.dart';

abstract class AbstactWinpayService {
  Future<WinpayLayananResponse> getLayanan(String baseurl);
  Future<WinpayPaymentResponse> requestPayment(
      {required WinpayPaymentRequest request, required String baseurl});
}

class WinpayService extends BaseService implements AbstactWinpayService {
  @override
  Future<WinpayLayananResponse> getLayanan(String baseurl) async {
    httpdio.options.baseUrl = baseurl;
    var resp = await httpdio.get("/winpay/layanan");
    return WinpayLayananResponse.fromJson(resp.data);
  }

  @override
  Future<WinpayPaymentResponse> requestPayment(
      {required WinpayPaymentRequest request, required String baseurl}) async {
    httpdio.options.baseUrl = baseurl;
    var resp = await httpdio.post("/winpay/payload", data: request);
    return WinpayPaymentResponse.fromJson(resp.data);
  }
}
