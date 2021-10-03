import 'package:flutter/material.dart';

import 'package:otp_screen/otp_screen.dart';
import 'package:flutter_session/flutter_session.dart';
import '../services/api_service.dart';
import '../screens/home_page.dart';

class OTP_Page extends StatefulWidget {
  static String routeName = "otpPage";

  @override
  _OTP_PageState createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  String _phone;
  Future<String> validateOtp(String otp) async {
    var userId = await FlutterSession().get("userId");
    ApiService api = ApiService();
    var cn = await api.phoneVerify(otp, userId);
    bool error = cn["hasError"];
    await Future.delayed(Duration(milliseconds: 2000));
    await FlutterSession().set("hasLogIn", true);
    if (!error) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      return "The entered Otp is wrong";
    }
  }

  dynamic number() async {
    var phone = await FlutterSession().get("phone");

    // print("------------------------------------------");
    // print(user);
    // print("------------------------------------------");
    setState(() {
      _phone = phone;
    });
  }

  void moveToNextScreen(context) {
    //Navigator.push(context, MaterialPageRoute(
    //builder: (context) => SuccessfulOtpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    number();
    return SafeArea(
        child: Scaffold(
      body: OtpScreen.withGradientBackground(
        topColor: Color(0xFFcc2b5e),
        bottomColor: Color(0xFF8B0000),
        otpLength: 6,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        themeColor: Colors.white,
        titleColor: Colors.white,
        title: "Phone Number Verification",
        subTitle: 'Enter the code sent to \n $_phone',
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
      ),
    ));
  }
}
