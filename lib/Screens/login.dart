import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Screens/Signup.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helpers/Navigation.dart';
import '../Helpers/Network/Requesthttp.dart';
import 'Appointments/Appointment.dart';

class LoginPage extends StatefulWidget {
  final TokenDB database;
  final PatientsDB patientDatabase;

  const LoginPage({Key key, this.database, this.patientDatabase})
      : super(key: key);
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool buttonLd = false;
  bool _autoValidate = false;
  String emailOrMob = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();
  bool isObsolete = false;
  String dropdownValue = 'Doctor';
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String errorText = "Something wrong happend";
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    //errorController.close();
    super.dispose();
  }

  var response;

  // String urls = LOGINDOCTOR;
  // List<String> links = [
  //   LOGINDOCTOR,
  //   LOGINFRONTDESK,
  // ];

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email ID or mobile Number';
    else
      return null;
  }

  String validateMobile(String value) {
    if (value.isEmpty) {
      return "Field can't be empty";
    } else if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  void _validateInputs(TokenDB database,PatientsDB pd) async {
    if (_formKey.currentState.validate()) {
      print(pass);
      _formKey.currentState.save();
      bool isLoggedIn = await loginDoctor(emailOrMob, pass);
      if (!isLoggedIn) {
        print('hello');
        errorController.add(ErrorAnimationType.shake);
        setState(() {
          hasError = true;
          _btnController.reset();
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String doctors = pref.getString('dresponse');
        DoctorLogin docUser = DoctorLogin.fromJson(json.decode(doctors));
        // print(database.getcount());
        // print(docUser.data.isActive);
        if (docUser.data.isActive) {
          _btnController.success();
          Timer(
              Duration(seconds: 1),
              () => changeScreenRepacement(
                  context,
                  Appointments(
                    database: database,
                    patientDatabase: pd,
                  )));
        } else {
          print('not');
          _btnController.reset();
        }
      }
    } else {
      print('not2');
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
    final database = Provider.of<TokenDB>(context);
    final patientDatabase = Provider.of<PatientsDB>(context);
    return new Scaffold(
      backgroundColor: Colors.white,
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
            Center(
              child: SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 350.0,
                      width: 350.0,
                      child: Image.asset(
                        'images/docbg.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    new Form(
                        autovalidate: _autoValidate,
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 30.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              new TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Email Id or Mobile Number',
                                  icon: Icon(
                                    Icons.account_box,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.check_box,
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: validateMobile,
                                onSaved: (String val) {
                                  setState(() {
                                    emailOrMob = val;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    if (hasError || emailOrMob.isEmpty) {
                                      buttonLd = false;
                                    }
                                  });
                                },
                                keyboardType: TextInputType.phone,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Text(
                                  hasError ? errorText : "",
                                  style: TextStyle(
                                      color: Colors.red.shade300, fontSize: 15),
                                ),
                              ),
                              new TextFormField(
                                validator: (val) =>
                                val.isEmpty || val.length < 4
                                    ? 'Enter a valid password'
                                    : null,
                                onSaved: (String val) {
                                  setState(() {
                                    pass = val;
                                  });
                                },
                                decoration: new InputDecoration(
                                  hintText: 'Enter Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: isObsolete
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isObsolete = !isObsolete;
                                      });
                                    },
                                  ),
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: !isObsolete,
                                style: TextStyle(color: Colors.black),
                              ),
                              FlatButton(
                                  child: Text('New to app? Signup'),
                                  onPressed: () => changeScreenRepacement(
                                      context, SignUpPage())),
                              RoundedLoadingButton(
                                controller: _btnController,
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: white),
                                ),
                                color: orangef,
                                onPressed: () {
                                  _validateInputs(
                                      database,patientDatabase
                                  );
                                },
                              ),
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
