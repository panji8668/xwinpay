import 'package:rxdart/rxdart.dart';
import 'package:xwinpay/src/bloc/basebloc.dart';
import 'package:xwinpay/src/models/api_response.dart';
import 'package:xwinpay/src/models/winpaylayananresp.dart';
import 'package:xwinpay/src/models/winpaypaymentrequest.dart';
import 'package:xwinpay/src/models/winpaypaymentresponse.dart';
import 'package:xwinpay/src/services/winpayservices.dart';

class WinPayBloc extends BaseBloc {
  final _repo = WinpayService();
  late String baseurl;

  WinPayBloc({required String burl}) {
    baseurl = burl;
  }

  final _winpayprodukController =
      BehaviorSubject<ApiResponse<WinpayLayananResponse>>();
  Stream<ApiResponse<WinpayLayananResponse>> get winpayprodukStream =>
      _winpayprodukController.stream;

  final _winpayPaymentController =
      BehaviorSubject<ApiResponse<WinpayPaymentResponse>>();
  Stream<ApiResponse<WinpayPaymentResponse>> get winpayPaymentStream =>
      _winpayPaymentController.stream;

  initGetwinpayProduk(){
      _winpayprodukController.sink.add(ApiResponse.init());
  }

  getWinpayProduk() {
    try {
      _winpayprodukController.sink.add(ApiResponse.loading("Loading.."));
      _repo.getLayanan(baseurl).then((resp) {
        _winpayprodukController.sink.add(ApiResponse.completed(resp));
      }).catchError((e) {
        _winpayprodukController.sink.add(ApiResponse.error(e.toString()));
      });
    } catch (e) {
      _winpayprodukController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  initReqPayment(){
    _winpayPaymentController.sink.add(ApiResponse.init());
  }

  doReqPayment({required int amount, required int userid, required String channel}){

    try {
      //_winpayprodukController.sink.add(ApiResponse.loading("Loading.."));
      WinpayPaymentRequest req = WinpayPaymentRequest(userid: userid, amount: amount, channel: channel, hash: "");
      _winpayPaymentController.sink.add(ApiResponse.loading("Loading.."));
      _repo.requestPayment(request: req, baseurl: baseurl).then((resp) {
        _winpayPaymentController.sink.add(ApiResponse.completed(resp));
      }).catchError((e) {
        _winpayPaymentController.sink.add(ApiResponse.error("Channel Pembayaran sedang maintenance"));
      });
    } catch (e) {
      _winpayPaymentController.sink.add(ApiResponse.error(e.toString()));
    }

  }


  @override
  void dispose() {
    _winpayprodukController.close();
  }
}
