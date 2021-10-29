import 'dart:async';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Screens/DoctorRegistration/CompleteProfile.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Otp extends StatefulWidget {
  final String mobno;
  final String password;
  final String generated;
  Otp({this.mobno, this.password, this.generated});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String errorText = "Incorrect OTP";
  String currentText;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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

  final cont = Container(
    height: 40.0,
    width: 40.0,
    color: orangef,
  );
  @override
  Widget build(BuildContext context) {
    print(widget.generated);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: SafeArea(
        child: new Stack(
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
            SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  Container(
                    height: 350.0,
                    width: 350.0,
                    child: Image.network(
                      'https://image.freepik.com/free-vector/security-otp-one-time-password-smartphone-shield_9904-104.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    'Phone Number Verification',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    'Enter the code sent to +91 ${widget.mobno}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      length: 6,
                      autoDismissKeyboard: true,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: white,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? errorText : "",
                      style:
                      TextStyle(color: Colors.red.shade300, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () async {
                          print(currentText+"=="+widget.generated.substring(1,7)  );
                          print(currentText.compareTo(widget.generated));

                          if (currentText.length != 6||
                              currentText.trim() !=widget.generated.substring(1,7)  ) {
                            errorController.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            setState(() {
                              hasError = false;
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Success!!"),
                                duration: Duration(seconds: 2),
                              ));
                            });
                            if (await signupDoctor(
                                widget.mobno, currentText, widget.password)) {
                              changeScreenRepacement(
                                  context, CompleteProfile());
                            } else {
                              setState(() {
                                hasError = true;
                              });
                              errorController.add(ErrorAnimationType.shake);
                            }
                          }
                        },
                        child: Center(
                            child: Text(
                              "VERIFY".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green.shade200,
                              offset: Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.green.shade200,
                              offset: Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
