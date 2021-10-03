// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:stripe_payment/stripe_payment.dart';
// import '../services/api_service.dart';

// class StripeTransactionResponse {
//   String message;
//   bool success;
//   StripeTransactionResponse({this.message, this.success});
// }

// class StripeService {
//   final ApiService api = ApiService();
//   static String apiBase = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
//   static String secret =
//       'sk_test_51HArokCAtyjlhEIMvbHTpmlhyme7b4Y0AYDtsUjYUGwU5QcL9zHUsps51w64yOHgPQyVzY1kH7RadIW96Q55YzR700mekUAJto';
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${StripeService.secret}',
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };
//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey:
//             "pk_test_51HArokCAtyjlhEIMp36IzBHAoMObEl8U4k7XSY9D2btXmb2qAkTo4p5O1DTO8RjNT8RqSh9xas4YVyiUknDxPsa8003xs1iubt",
//         merchantId: "test",
//         androidPayMode: 'test'));
//   }

//   static Future<StripeTransactionResponse> payViaExistingCard(
//       {String amount, String currency, CreditCard card}) async {
//     try {
//       var paymentMethod = await StripePayment.createPaymentMethod(
//           PaymentMethodRequest(card: card));
//       var paymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent['client_secret'],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (err) {
//       print(err);
//       return new StripeTransactionResponse(
//           message: 'Transaction failed: ${err.toString()}', success: false);
//     }
//   }

//   static Future<StripeTransactionResponse> confirmPayment(
//       {String clientSecret, String cardId}) async {
//     try {
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//         clientSecret: clientSecret,
//         paymentMethodId: cardId,
//       ));
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (err) {
//       print("erdddddddddddddddddddddr");
//       print(err);
//       print("erdddddddddddddddddddddr");
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (err) {
//       print("------------------frt---------------");
//       print(err);

//       return new StripeTransactionResponse(
//           message: 'Transaction failed: ${err.toString()}', success: false);
//     }
//   }

//   static getPlatformExceptionErrorResult(err) {
//     String message = 'Something went wrong';
//     if (err.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }

//     return new StripeTransactionResponse(message: message, success: false);
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       // Map<String, dynamic> body = {
//       //   'amount': amount,
//       //   'currency': currency,
//       //   'payment_method_types[]': 'card'
//       // };
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'shopId': currency,
//       };
//       var response = await http.post("paymentIntentForMobile",
//           body: body, headers: StripeService.headers);
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//     return null;
//   }
// }
