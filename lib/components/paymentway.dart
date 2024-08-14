import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePayButtonWrapper extends StatelessWidget {
  final String amount;
  final String currency;

  GooglePayButtonWrapper({required this.amount, required this.currency});

  void onGooglePayResult(paymentResult) {
    // TODO: Send the resulting Google Pay token to your server / PSP
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    const String defaultGooglePay = '''{
      "provider": "google_pay",
      "data": {
        "environment": "TEST",
        "apiVersion": 2,
        "apiVersionMinor": 0,
        "allowedPaymentMethods": [{
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }],
        "merchantInfo": {
          "merchantId": "01234567890123456789",
          "merchantName": "Example Merchant Name"
        },
        "transactionInfo": {
          "countryCode": "INDIA",
          "currencyCode": "INR"
        }
      }
    }''';

    final paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: amount,
        status: PaymentItemStatus.final_price,
      )
    ];

    return Container(

      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),

      ),
      child: GooglePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
        paymentItems: paymentItems,
        type: GooglePayButtonType.pay,
        onPaymentResult: onGooglePayResult,
        loadingIndicator:  Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}