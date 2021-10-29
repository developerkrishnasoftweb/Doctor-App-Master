import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Widgets/otp.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Helpers/Navigation.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  State createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool buttonLoad = false;
  bool _autoValidate = false;
  String mobno = '';
  String password = '';
  bool isPObsolete = false;
  bool isCpObsolete = false;
  final _formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String errorText = "Doctor Already Exists! Please login";
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  Future<void> _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String otpgenerated = await generateOtp(mobno);
      if (otpgenerated == null) {
        errorController.add(ErrorAnimationType.shake);
        setState(() {
          hasError = true;
        });
        _btnController.reset();
      } else {
        _btnController.success();
        changeScreenRepacement(context,
            Otp(mobno: mobno, password: password, generated: otpgenerated));
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
      _btnController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cont = Container(
      height: 40.0,
      width: 40.0,
      color: orangef,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(height: 15, width: 80, color: pcolor),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 15.0,
                            left: 0.0,
                            child: Container(
                                height: 45.0, width: 45.0, color: orangef),
                          ),
                        ],
                      ))),
                  Align(
                    alignment: Alignment.topRight,
                    child: cont,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 23.0,
                            right: 25.0,
                            child: Container(
                                height: 40.0, width: 40.0, color: pcolor),
                          ),
                        ],
                      ))),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: cont,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      color: orangef,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 15.0,
                            right: 0.0,
                            child: Container(
                                height: 70.0, width: 15.0, color: pcolor),
                          ),
                        ],
                      ))),
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.asset(
                      'images/docbg.png',
                      height: 350,
                    ),
                    new Form(
                        autovalidate: _autoValidate,
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      prefixText: '+91 ',
                                      hintText: 'Mobile Number',
                                      icon: Icon(
                                        Icons.phone_iphone,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    validator: validateMobile,
                                    onSaved: (String val) {
                                      setState(() {
                                        mobno = val;
                                      });
                                      print(mobno);
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Text(
                                      hasError ? errorText : "",
                                      style: TextStyle(
                                          color: Colors.red.shade300,
                                          fontSize: 15),
                                    ),
                                  ),
                                  new TextFormField(
                                    validator: (val) =>
                                        val.isEmpty || val.length < 6
                                            ? 'Enter a valid password'
                                            : null,
                                    onChanged: (String val) {
                                      password = val;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: 'Enter Password',
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: isPObsolete
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPObsolete = !isPObsolete;
                                          });
                                        },
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    obscureText: !isPObsolete,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  new TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty || val.length < 6) {
                                        return 'Enter a valid password';
                                      } else if (val != password) {
                                        return 'Password do not match';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      hintText: 'Confirm Password',
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: isCpObsolete
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isCpObsolete = !isCpObsolete;
                                          });
                                        },
                                      ),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !isCpObsolete,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10.0)),
                                ],
                              ),
                              FlatButton(
                                onPressed: () =>
                                    changeScreen(context, LoginPage()),
                                child: Text('Already have an Account? Login'),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width <= 360
                                    ? 250
                                    : 350,
                                child: RoundedLoadingButton(
                                  controller: _btnController,
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(color: white),
                                  ),
                                  color: orangef,
                                  onPressed: () {
                                    _validateInputs();
                                  },
                                ),
                              ),
                              // MaterialButton(
                              //   height: 58.0,
                              //   minWidth: 100.0,
                              //   color: pcolor,
                              //   textColor: Colors.white,
                              //   child: buttonLoad
                              //       ? CircularProgressIndicator()
                              //       : new Icon(
                              //           Icons.exit_to_app,
                              //           size: 30.0,
                              //         ),
                              //   shape: CircleBorder(side: BorderSide.none),
                              //   onPressed: () {
                              //     setState(() {
                              //       buttonLoad = true;
                              //     });
                              //     _validateInputs();
                              //   },
                              //   splashColor: Colors.redAccent,
                              // ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
