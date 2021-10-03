// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
// import '../models/cardModel.dart';
// import '../widgets/cardList.dart';
// import '../screens/card.dart';
// import '../services/api_service.dart';

// class ManagaCardsScreen extends StatefulWidget {
//   final userId;
//   ManagaCardsScreen({this.userId});
//   static String routeName = "card_list";
//   @override
//   _ManagaCardsScreenState createState() => _ManagaCardsScreenState();
// }

// class _ManagaCardsScreenState extends State<ManagaCardsScreen> {
//   List<CardModel> cards;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         title: Text(
//           "Cards",
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // do something
//             },
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<CardModel>>(
//               future: null, // ApiService.userCards(userId: widget.userId),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) print(snapshot.error);

//                 return snapshot.hasData
//                     ? CardList(
//                         cards: snapshot.data) // return the ListView widget
//                     : Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: RaisedButton(
//                 textColor: Colors.white,
//                 color: Colors.green,
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => CreditCard(
//                             title: "Add New Card",
//                           )));
//                 },
//                 child: Text('Add payment method'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
