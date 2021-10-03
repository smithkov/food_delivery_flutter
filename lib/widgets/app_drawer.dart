import 'package:flutter/material.dart';
import 'package:foodengo/models/user.dart';
import 'package:foodengo/provider/providerData.dart';
import 'package:foodengo/screens/previousOrderPage.dart';
import 'package:provider/provider.dart';
import '../screens/signin_page.dart';
import '../screens/profile.dart';
import 'package:flutter_session/flutter_session.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
    checkForLogin();
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  String firstName = "";
  var hasLogedIn = false;

  void checkForLogin() async {
    var hasLogin = await FlutterSession().get("hasLogIn");

    if (hasLogin == true) {
      setState(() {
        hasLogedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<ProviderData>(context).userDetail();
    if (user != null) {
      setState(() {
        firstName = user.firstName;
      });
    }
    return Drawer(
        child: hasLogedIn
            ? Column(
                children: <Widget>[
                  AppBar(
                    title: Text('Hello $firstName'),
                    automaticallyImplyLeading: false,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text('Shop'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Orders'),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(PreviousOrderPage.routeName);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfilePage.routeName);
                    },
                  ),
                  // Divider(),
                  // ListTile(
                  //   leading: Icon(Icons.exit_to_app),
                  //   title: Text('Manage Cards'),
                  //   onTap: () async {
                  //     String userId = await FlutterSession().get("userId");
                  //     Navigator.of(context).pop();

                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => ManagaCardsScreen(
                  //               userId: userId,
                  //             )));
                  //   },
                  // ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () async {
                      var user = await FlutterSession().set("hasLogIn", false);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SignInPage.routeName);

                      //Provider.of<Auth>(context, listen: false).logout();
                    },
                  ),
                ],
              )
            : SafeArea(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                           Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignInPage()));
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                  ),
                ]),
              ));
  }
}
