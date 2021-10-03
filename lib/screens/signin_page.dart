import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:flutter_session/flutter_session.dart';
import '../screens/home_page.dart';
import '../models/user.dart';
import '../screens/signup_page.dart';

class SignInPage extends StatefulWidget {
  static String routeName = "signIn";
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggleVisibility = true;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String _password;
  String _email;
  bool _isLogin = false;

  Widget _buildEmailTextField() {
    return TextFormField(
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
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
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
                          _buildEmailTextField(),
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
                  Center(
                    child: Text(
                      "Forgotten Password?",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildSignInButton(),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignUpPage()));
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      child: _isLogin
          ? Center(child: CircularProgressIndicator())
          : RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () async {
                setState(() {
                  _isLogin = true;
                });
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  ApiService api = ApiService();

                  var userLogin = await api.signIn(_email, _password);

                  print(userLogin);

                  // bool error = cn["hasError"];

                  if (!userLogin.error) {
                    String firstName = userLogin.firstName;
                    String id = userLogin.id;

                    await FlutterSession().set("firstName", firstName);

                    await FlutterSession().set("userId", id);
                    await FlutterSession().set("hasLogIn", true);

                    //var userInfo = await FlutterSession().get("userInfo");
                    //print(foo);
                    Navigator.of(context)
                        .pushReplacementNamed(HomePage.routeName);
                  } else {
                    print("---------------------------------------------");
                    // Navigator.of(context).pop();
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 10),
                        backgroundColor: Colors.red,
                        content: Text("Invalid username or password."),
                      ),
                    );
                  }
                }
                setState(() {
                  _isLogin = false;
                });
              },
              child: Text("Sign In")),
    );
  }
}
