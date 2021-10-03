import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './signin_page.dart';
import '../screens/home_page.dart';
import 'package:flutter_session/flutter_session.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  var hasLogedIn = false;
  @override
  void initState() {
    super.initState();
    checkForLogin();
  }

  void checkForLogin() async {
    var hasLogIn = await FlutterSession().get("hasLogIn");
    if (hasLogIn == true) {
      
      setState(() {
        hasLogedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 

    new SplashScreen(
            seconds: 5,
            navigateAfterSeconds: new HomePage(),
            title: new Text(
              'Welcome to Foodengo',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            image: new Image.asset('images/logo.JPG'),
            backgroundColor: Colors.red[900],
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            onClick: () => print(""),
            loaderColor: Colors.red);
    // return hasLogedIn
    //     ? HomePage()
    //     : new SplashScreen(
    //         seconds: 5,
    //         navigateAfterSeconds: new SignInPage(),
    //         title: new Text(
    //           'Welcome to Foodengo',
    //           style: new TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 20.0,
    //               color: Colors.white),
    //         ),
    //         image: new Image.asset('images/logo.JPG'),
    //         backgroundColor: Colors.red[900],
    //         styleTextUnderTheLoader: new TextStyle(),
    //         photoSize: 100.0,
    //         onClick: () => print(""),
    //         loaderColor: Colors.red);
  }
}
