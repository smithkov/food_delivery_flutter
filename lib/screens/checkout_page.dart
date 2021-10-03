import 'package:foodengo/models/user.dart';
import 'package:foodengo/provider/providerData.dart';
import 'package:provider/provider.dart';

import '../models/shopCart.dart';
import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../utility/reusable.dart';
import '../services/api_service.dart';
import '../screens/checkout_web.dart';

class CheckoutPage extends StatefulWidget {
  // final FoodModel foodModel;

  final Shop shop;
  final String total;

  CheckoutPage({this.shop, this.total});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ShopCart cart;
  String name;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final postCodeController = TextEditingController();
  final messageController = TextEditingController();
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<ProviderData>(context).userDetail();
    if (user != null) {
      nameController.text = user.firstName;
      phoneController.text = user.phone;
      addressController.text = user.firstAddress;
      postCodeController.text = user.postCode;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your details'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Your delivery address',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    smallSpacer(),
                    Text(
                      'We could not find your address, please kindly enter a new address for delivery',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            spacer(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Your details',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: nameController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration:
                  Reusable.inputDecoration(Icons.person, Colors.grey, "User"),
              onChanged: (value) {},
            ),
            spacer(),
            TextField(
              controller: phoneController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration:
                  Reusable.inputDecoration(Icons.phone, Colors.grey, "Phone"),
              onChanged: (value) {},
            ),
            spacer(),
            TextField(
              controller: addressController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: Reusable.inputDecoration(
                  Icons.location_city, Colors.grey, "Address"),
              onChanged: (value) {},
            ),
            spacer(),
            TextField(
              controller: postCodeController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: Reusable.inputDecoration(
                  Icons.location_pin, Colors.grey, "Post code"),
              onChanged: (value) {},
            ),
            spacer(),
            Text(
              'If your order includes alcohol please have your ID ready for contact-free verification. Tell us about any special delivery instructions below. Do not include details about any allergies.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: messageController,
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  "Please leave my order outside my door"),
                        ),
                      )),
                ),
              ],
            ),
            spacer(),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  var updateAddress = await ApiService.updateAddress(
                      phone: phoneController.text,
                      firstAddress: addressController.text,
                      postCode: postCodeController.text);
                  var updateMessage = await ApiService.deliveryMessage(
                      message: messageController.text, shopId: widget.shop.id);
                  var checkout = await ApiService.stripeSession(
                      shopId: widget.shop.id, amount: widget.total.toString());
                  String sessionId = checkout["id"] as String;

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Checkout_Web(sessionId: sessionId),
                  ));
                },
                child: Text(
                  "Proceed to payment",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            spacer()
          ],
        ),
      ),
    );
  }

  Widget spacer() {
    return SizedBox(
      height: 20.0,
    );
  }

  Widget smallSpacer() {
    return SizedBox(
      height: 10.0,
    );
  }
}
