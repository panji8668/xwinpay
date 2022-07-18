import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xwinpay/src/bloc/winpaybloc.dart';
import 'package:xwinpay/src/helper/utils.dart';
import 'package:xwinpay/src/models/api_response.dart';
import 'package:xwinpay/src/models/winpaypaymentresponse.dart';
import 'package:xwinpay/src/widgets/errorpanel.dart';
import 'package:xwinpay/src/widgets/loadinglayout.dart';

class WebViewPage extends StatefulWidget {
  final String baseurl;
  final String channel;
  final int amount;
  final int userid;
  const WebViewPage(
      {Key? key,
      required this.baseurl,
      required this.channel,
      required this.amount,
      required this.userid})
      : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final WinPayBloc _bloc = WinPayBloc(burl: "");

  @override
  void initState() {
    super.initState();
    _bloc.baseurl = widget.baseurl;
    onWidgetDidBuild(() {
      _bloc.doReqPayment(
          amount: widget.amount,
          userid: widget.userid,
          channel: widget.channel);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  int? _stackToView = 1;
  final _key = UniqueKey();
  _onpageFinish(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Info Pembayaran"),
        elevation: 0.0,
      ),
      body: StreamBuilder<ApiResponse<WinpayPaymentResponse>>(
          stream: _bloc.winpayPaymentStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.status == Status.ERROR) {
                return ErrorPanel(
                    title: snapshot.data!.message!,
                    label: "Kembali",
                    onclick: () {
                      Navigator.pop(context);
                    });
              }
              if (snapshot.data!.status == Status.LOADING) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: const Text("Sedang menyiapkan kode pembayaran"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.status == Status.COMPLETED) {
                if (snapshot.data!.data.data.rc == "00") {
                  return IndexedStack(
                    index: _stackToView,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                              child: WebView(
                            key: _key,
                            javascriptMode: JavascriptMode.unrestricted,
                            initialUrl:
                                snapshot.data!.data.data.data.spiStatusUrl,
                            onPageFinished: _onpageFinish,
                            navigationDelegate: (NavigationRequest request) {
                              return NavigationDecision.navigate;
                            },
                          )),
                        ],
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const Text("Loading..."),
                            ),
                            Container(
                              color: Colors.white,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return ErrorPanel(
                      title: snapshot.data!.data.data.rd,
                      label: "Kembali",
                      onclick: () {
                        Navigator.of(context).pop();
                      });
                }
              }
            }
            return const Center(child: LoadingLayout());
          }),
    );
  }
}
