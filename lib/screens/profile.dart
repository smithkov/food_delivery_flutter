import '../models/user.dart';
import '../provider/providerData.dart';
import 'package:provider/provider.dart';
import '../models/shopCart.dart';
import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../utility/reusable.dart';
import '../services/api_service.dart';

class ProfilePage extends StatefulWidget {
  // final FoodModel foodModel;
  static String routeName = "profile";
  final Shop shop;
  final String total;

  ProfilePage({this.shop, this.total});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ShopCart cart;
  String name;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final postCodeController = TextEditingController();
  final messageController = TextEditingController();

  final ApiService api = ApiService();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<ProviderData>(context).userDetail();
    if (user != null) {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      phoneController.text = user.phone;
      addressController.text = user.firstAddress;
      postCodeController.text = user.postCode;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your details'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your details',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            spacer(),
            TextField(
              controller: firstNameController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: Reusable.inputDecoration(
                  Icons.person, Colors.grey, "First name"),
              onChanged: (value) {},
            ),
            spacer(),
            TextField(
              controller: lastNameController,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: Reusable.inputDecoration(
                  Icons.person, Colors.grey, "Last name"),
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
            RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  bool updateUser = await ApiService.updateUser(
                      phone: phoneController.text,
                      firstAddress: addressController.text,
                      postCode: postCodeController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text);

                  if (!updateUser) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 10),
                        backgroundColor: Colors.green,
                        content: Text("Saved successfully"),
                      ),
                    );
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 10),
                        backgroundColor: Colors.green,
                        content: Text("Did not save"),
                      ),
                    );
                  }
                },
                child: Text(
                  "Update",
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
