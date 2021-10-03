import 'package:flutter/material.dart';
import '../screens/otp_page.dart';
import '../services/api_service.dart';
import 'package:flutter_session/flutter_session.dart';
import '../screens/signin_page.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = "signUp";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String _password;
  String _email;
  String _firstName;
  String _lastName;
  String _phone;
  bool _isLogin = false;

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String email) {
        _email = email.trim();
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Invalid email";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 11,
      decoration: InputDecoration(
        hintText: "eg. 07857965054",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String phone) {
        _phone = phone.trim();
      },
      validator: (String phone) {
        if (phone.isEmpty) {
          return 'Please provide your first name';
        }
        return null;
      },
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "FirstName",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String firstName) {
        _firstName = firstName.trim();
      },
      validator: (String firstName) {
        if (firstName.isEmpty) {
          return 'Please provide your first name';
        }
        return null;
      },
    );
  }

  Widget _buildTextField2() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "LastName",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String lastName) {
        _lastName = lastName.trim();
      },
      validator: (String lastName) {
        if (lastName.isEmpty) {
          return 'Please provide your last name';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (String password) {
        _password = password;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 40,
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            _buildTextField2(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildEmailTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildPhoneTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildPasswordTextField(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            ApiService api = ApiService();

                            var cn = await api.register(_email, _password,
                                _firstName, _lastName, _phone);

                            print(cn["obj"]);

                            bool error = cn["hasError"];

                            if (!error) {
                              final userId = cn["obj"]['id'];
                              await FlutterSession().set("userInfo", cn["obj"]);
                              await FlutterSession().set("phone", _phone);
                              await FlutterSession().set("userId", userId);
                              

                              Navigator.of(context)
                                  .pushReplacementNamed(OTP_Page.routeName);
                            }
                          }
                        },
                        child: Text("Sign Up")),
                    Divider(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            // SignUpPage()));
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignInPage()));
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  // Widget _buildSignInButton() {
  //   return Container(
  //     width: double.infinity,
  //     child: _isLogin
  //         ? Center(child: CircularProgressIndicator())
  //         : RaisedButton(
  //             color: Theme.of(context).primaryColor,
  //             onPressed: () async {
  //               if (_formKey.currentState.validate()) {
  //                 _formKey.currentState.save();

  //                 ApiService api = ApiService();

  //                 var cn = await api.signIn(_email, _password);

  //                 //print(cn);
  //                 await FlutterSession().set("userInfo", cn);
  //                 //var foo = await FlutterSession().get("foo");
  //                 //print(foo);
  //                 Navigator.of(context)
  //                     .pushReplacementNamed(HomePage.routeName);

  //                 setState(() {
  //                   _isLogin = false;
  //                 });
  //               }
  //             },
  //             child: Text("Sign Up")),
  //   );
  //   // return GestureDetector(
  //   //   onTap: () => {_formKey.currentState.save()},
  //   //   child: Button(btnText: "Sign In"),
  //   // );
  // }

  void _saveForm() async {
    // setState(() {
    //   _isLogin = true;
    // });
    //
    //print(UserInfo.userInfo);
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   print("fffffffffffffffffffffffffffff");
    //   ApiService api = ApiService();
    //   print("33333333333333333333333333333");
    //   var cn = await api.signIn(_email, _password);
    //   UserInfo.setUserInfo(cn);
    //   print(cn);
    //   // setState(() {
    //   //   _isLogin = false;
    //   // });
    // }
  }

  void onSubmit() {
    // Navigator.of(context).pushReplacementNamed("/mainscreen");
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();

    //authenticate(_email, _password).then((final response) {
//        if (!response['hasError']) {
//          Navigator.of(context).pop();
//          Navigator.of(context).pushReplacementNamed("/mainscreen");
//        } else {
//          Navigator.of(context).pop();
//          _scaffoldKey.currentState.showSnackBar(
//            SnackBar(
//              duration: Duration(seconds: 2),
//              backgroundColor: Colors.red,
//              content: Text(response['message']),
//            ),
//          );
//        }
    //});
    //}
  }
}
