// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
// import 'package:flutter_credit_card/credit_card_widget.dart';
// import 'package:flutter_session/flutter_session.dart';
// import '../services/api_service.dart';

// class CreditCard extends StatefulWidget {
//   static String routeName = "new_card";
//   CreditCard({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _CreditCardState createState() => _CreditCardState();
// }

// class _CreditCardState extends State<CreditCard> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   bool isCvvFocused = false;
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: <Widget>[
//               CreditCardWidget(
//                 cardNumber: cardNumber,
//                 expiryDate: expiryDate,
//                 cardHolderName: cardHolderName,
//                 cvvCode: cvvCode,
//                 showBackView:
//                     isCvvFocused, //true when you want to show cvv(back) view
//               ),
//               CreditCardForm(
//                 themeColor: Colors.red,
//                 onCreditCardModelChange: (CreditCardModel data) {
//                   setState(() {
//                     cardNumber = data.cardNumber;
//                     expiryDate = data.expiryDate;
//                     cardHolderName = data.cardHolderName;
//                     cvvCode = data.cvvCode;
//                     isCvvFocused = data.isCvvFocused;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // String stripeId = await FlutterSession().get("stripeCustomerId");
//           // String userId = await FlutterSession().get("userId");
//           // if (stripeId == null) {
//           //   stripeId = await ApiService.createStripeAccount(userId);
//           // }

//           // int cvc = int.tryParse(cvvCode);
//           // int carNo =
//           //     int.tryParse(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
//           // String exp_year = expiryDate.substring(3, 5);
//           // String exp_month = expiryDate.substring(0, 2);

//           // print("cvc num: ${cvc.toString()}");
//           // print("card num: ${carNo.toString()}");
//           // print("exp year: ${exp_year.toString()}");
//           // print("exp month: ${exp_month.toString()}");
//           // print(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));

//           // var newCard = await ApiService.createCard(
//           //     cardNo: carNo.toString(),
//           //     cvc: cvc.toString(),
//           //     expMonth: exp_month.toString(),
//           //     expYear: exp_year.toString(),
//           //     stripeId: stripeId.toString(),
//           //     userId: userId.toString());
//           // bool error = newCard["error"] as bool;
//           // String message = newCard["message"];
//           // var msgColor = error ? Colors.red : Colors.green;
//           // _scaffoldKey.currentState.showSnackBar(
//           //   SnackBar(
//           //     duration: Duration(seconds: 10),
//           //     backgroundColor: msgColor,
//           //     content: Text(message),
//           //   ),
//           // );
//           //StripeServices stripeServices = StripeServices();
//           // if(user.userModel.stripeId == null){
//           //  String stripeID = await stripeServices.createStripeCustomer(email: user.userModel.email, userId: user.user.uid);
//           //  print("stripe id: $stripeID");
//           //  print("stripe id: $stripeID");
//           //  print("stripe id: $stripeID");
//           //  print("stripe id: $stripeID");

//           //  stripeServices.addCard(stripeId: stripeID, month: exp_month, year: exp_year, cvc: cvc, cardNumber: carNo, userId: user.user.uid);
//           // }else{
//           //   stripeServices.addCard(stripeId: user.userModel.stripeId, month: exp_month, year: exp_year, cvc: cvc, cardNumber: carNo, userId: user.user.uid);
//           // }
//           // user.hasCard();
//           // user.loadCardsAndPurchase(userId: user.user.uid);

//           // changeScreenReplacement(context, HomeScreen());
//         },
//         tooltip: 'Submit',
//         child: Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
