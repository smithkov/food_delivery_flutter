import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/previousOrderPage.dart';

class PaymentStatus extends StatelessWidget {
  // final FoodModel foodModel;

  final bool isError;

  PaymentStatus({
    this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order Status'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
          child: !isError
              ? Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Not long now, your order was successful.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Image.asset("images/delivery.png"),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PreviousOrderPage()));
                        },
                        child: Text(
                          "My orders",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
                        },
                        child: Text(
                          "Browse restaurants",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: Text("Payment could not go through"))),
    );
  }

  Widget spacer() {
    return SizedBox(
      height: 2,
    );
  }
}
