library xwinpay;

import 'package:flutter/material.dart';
import 'package:xwinpay/src/bloc/winpaybloc.dart';
import 'package:xwinpay/src/helper/utils.dart';
import 'package:xwinpay/src/models/api_response.dart';
import 'package:xwinpay/src/models/winpaylayananresp.dart';
import 'package:xwinpay/src/widgets/errorpanel.dart';
import 'package:xwinpay/src/widgets/loadinglayout.dart';
import 'package:xwinpay/src/widgets/webviewpage.dart';

import 'src/widgets/paymentmethoditem.dart';

class WinpayPaymentMethod extends StatefulWidget {
  final int amount;
  final String baseurl;
  final int userid;
  const WinpayPaymentMethod(
      {Key? key,
      required this.amount,
      required this.baseurl,
      required this.userid})
      : super(key: key);

  @override
  State<WinpayPaymentMethod> createState() => _WinpayPaymentMethodState();
}

class _WinpayPaymentMethodState extends State<WinpayPaymentMethod> {
  final WinPayBloc _bloc = WinPayBloc(burl: "");

  @override
  void initState() {
    super.initState();
    _bloc.baseurl = widget.baseurl;
    onWidgetDidBuild(() {
      _bloc.getWinpayProduk();
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<WinpayLayananResponse>>(
        stream: _bloc.winpayprodukStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.status == Status.ERROR) {
              return ErrorPanel(
                  title: "Terjadi kesalahan"+snapshot.data!.message!,
                  onclick: () {
                    _bloc.getWinpayProduk();
                  });
            }
            if (snapshot.data!.status == Status.LOADING) {
              return const LoadingLayout();
            }
            if (snapshot.data!.status == Status.COMPLETED) {
              return Container(
                margin: const EdgeInsets.all(1),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            color: Colors.black12,
                            child: const Text("MODERN STORE")),
                        ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return PaymentMethodItem(
                                  ontap: (channel) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewPage(
                                                  baseurl: widget.baseurl,
                                                  amount: widget.amount,
                                                  userid: widget.userid,
                                                  channel: channel,
                                                )));
                                  },
                                  service: snapshot.data!.data.layanan
                                      .modernStore[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemCount: snapshot
                                .data!.data.layanan.modernStore.length),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(5),
                            color: Colors.black12,
                            child: const Text("VIRTUAL ACCOUNT")),
                        ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return PaymentMethodItem(
                                  ontap: (channel) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WebViewPage(
                                                  baseurl: widget.baseurl,
                                                  amount: widget.amount,
                                                  userid: widget.userid,
                                                  channel: channel,
                                                )));
                                  },
                                  service: snapshot.data!.data.layanan
                                      .virtualAccount[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemCount: snapshot
                                .data!.data.layanan.virtualAccount.length),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(child: LoadingLayout());
        });
  }
}
