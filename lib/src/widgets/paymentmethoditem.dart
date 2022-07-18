import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xwinpay/src/models/winpaylayananresp.dart';

class PaymentMethodItem extends StatelessWidget {
  final ProdukWinpay service;
  final Function(String channel) ontap;
  const PaymentMethodItem({Key? key, required this.service, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
          ontap(service.paymentCode);
      },
      title: Text(service.paymentName),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: service.paymentLogo,
            width: 48),
      ),
      trailing: const Icon(Icons.navigate_next),
    );
  }
}
