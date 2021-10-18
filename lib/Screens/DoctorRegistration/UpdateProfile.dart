import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class UpdateProfile extends StatefulWidget {
  final String docid;
  final List<ClinicDoctor> clinicDoctors;

  const UpdateProfile({Key key, this.docid, this.clinicDoctors})
      : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyFees = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _feesbtnController =
      new RoundedLoadingButtonController();
  bool showPass = true;
  String name;
  int age;
  String email;
  String password;
  String phoneNo;
  String genderValue;
  String genderChangeValue;
  String degree;
  String language;
  String experience;
  String designation;
  String image;
  int opdFees;
  int emergFees;
  List<String> speciality;
  DateTime dob = DateTime.now();
  bool succes = false;
  var imageUrl;
  final picker = ImagePicker();
  bool isloading = false;
  ClinicDoctor _selectedClinic;

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email ID or mobile Number';
    else
      return null;
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool result = await updatedetails(
        widget.docid,
        name,
        age.toString(),
        genderValue,
        degree,
        phoneNo,
        email,
        language,
        experience,
        designation,
      );
      if (result == true) {
        setState(() {});
        _btnController.success();
        Fluttertoast.showToast(
                msg: "Profile updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: green,
                textColor: black,
                fontSize: 16.0)
            .then((value) => Navigator.pop(context));
        namectrl.clear();
        agectrl.clear();
        emailctrl.clear();
        passwordctrl.clear();
        phoneNoctrl.clear();
        degreectrl.clear();
        languagectrl.clear();
        experiencectrl.clear();
        designationctrl.clear();
      }
    } else {
      _btnController.reset();
      Fluttertoast.showToast(
          msg: "Some error Occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: red,
          textColor: black,
          fontSize: 16.0);
    }
  }

  void _validateFeesInputs() async {
    if (_formKeyFees.currentState.validate()) {
      _formKey.currentState.save();
      bool result = await updateFees(
        _selectedClinic.id.toString(),
        opdFeesctrl.text,
        emergFeesctrl.text,
      );
      if (result == true) {
        setState(() {});
        _btnController.success();
        Fluttertoast.showToast(
                msg: "Fees updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: green,
                textColor: black,
                fontSize: 16.0)
            .then((value) => Navigator.pop(context));
      }
    } else {
      _btnController.reset();
      Fluttertoast.showToast(
          msg: "Some error Occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: red,
          textColor: black,
          fontSize: 16.0);
    }
  }

  void genderNew(String value) {
    setState(() {
      genderValue = value;
      switch (value) {
        case 'male':
          genderChangeValue = value;
          break;
        case 'female':
          genderChangeValue = value;
          break;
        default:
          genderChangeValue = null;
      }
      debugPrint(genderChangeValue); //Debug the choice in console
    });
  }

  void getPreviousData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String docResponse = pref.getString('docDataResponse');
    DoctorLoginData doctor = DoctorLoginData.fromJson(json.decode(docResponse));
    setState(() {
      namectrl.text = name = doctor.name;
      age = doctor.age;
      agectrl.text = age.toString();
      emailctrl.text = email = doctor.email;
      passwordctrl.text = password = doctor.password;
      phoneNoctrl.text = phoneNo = doctor.mobileNo;
      degreectrl.text = degree = doctor.degree;
      languagectrl.text = language = doctor.language;
      experiencectrl.text = experience = doctor.experience;
      designationctrl.text = designation = doctor.designation;
      genderValue = doctor.gender;
      image = doctor.imageUrl;
    });
    ClinicDoctor cli = doctor.clinicDoctor
        .firstWhere((element) => element.id == _selectedClinic.id);
    setState(() {
      opdFeesctrl.text = cli.consultationFee.toString();
      emergFeesctrl.text = cli.emergencyFee.toString();
    });
  }

  @override
  void initState() {
    _selectedClinic = widget.clinicDoctors[0];
    super.initState();
    getPreviousData();
  }

  TextEditingController namectrl = TextEditingController();
  TextEditingController agectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  TextEditingController phoneNoctrl = TextEditingController();
  TextEditingController degreectrl = TextEditingController();
  TextEditingController languagectrl = TextEditingController();
  TextEditingController experiencectrl = TextEditingController();
  TextEditingController designationctrl = TextEditingController();
  TextEditingController opdFeesctrl = TextEditingController();
  TextEditingController emergFeesctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // title: Text("Update Profile"),
          // centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: image == null || image == ""
                    ? NetworkImage(
                        "https://img.icons8.com/windows/452/person-male.png")
                    : NetworkImage(image),
                coverImage: NetworkImage(
                    "https://img.freepik.com/free-photo/doctor-with-stethoscope-hands-hospital-background_1423-1.jpg?size=626&ext=jpg"),
                title: namectrl.text,
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "User Information",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: blue,
                      ),
                      // color: orangef,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        controller: namectrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Name",
                                            labelText: "Name",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.account_box,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          name = value;
                                        },
                                        validator: (value) => value.isEmpty
                                            ? 'Enter a valid name'
                                            : null,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: agectrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Age",
                                            labelText: "Age",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.account_box,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          age = int.parse(value);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        controller: emailctrl,
                                        // initialValue: aadharNo,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Email Id",
                                            labelText: "Email Id",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.email,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        validator: validateEmail,
                                        onSaved: (value) {
                                          email = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        controller: phoneNoctrl,
                                        // initialValue: phoneNo,
                                        keyboardType: TextInputType.number,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Phone Number",
                                            labelText: "Mobile Number",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          phoneNo = value;
                                        },
                                        validator: validateMobile,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Radio(
                                                  value: 'male',
                                                  groupValue: genderValue,
                                                  onChanged: genderNew),
                                              Text('Male')
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Radio(
                                                  value: 'female',
                                                  groupValue: genderValue,
                                                  onChanged: genderNew),
                                              Text('Female')
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        controller: degreectrl,
                                        // initialValue: aadharNo,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Degree",
                                            labelText: "Degree",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.email,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        // validator: validateEmail,
                                        onSaved: (value) {
                                          degree = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        controller: experiencectrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Experience",
                                            labelText: "Experience",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.home,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          experience = value;
                                        },
                                        // validator: validateMobile,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        // initialValue: pincode,
                                        controller: designationctrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Designation",
                                            labelText: "Designation",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.assessment,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          designation = value;
                                        },
                                        // validator: validateMobile,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      child: RoundedLoadingButton(
                                        controller: _btnController,
                                        color: Colors.orange[700],
                                        child: Text(
                                          "Update Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        onPressed: () {
                                          _validateInputs();
                                        },
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Change Fees",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: green),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: white)),
                              child: DropdownButton<ClinicDoctor>(
                                value: _selectedClinic,
                                hint: Text('Select Clinic'),
                                iconSize: 24,
                                elevation: 0,
                                style: TextStyle(color: white),
                                underline: Container(
                                  height: 2,
                                  color: Colors.transparent,
                                ),
                                onChanged: (ClinicDoctor newValue) {
                                  setState(() {
                                    _selectedClinic = newValue;
                                    opdFeesctrl.text = _selectedClinic
                                        .consultationFee
                                        .toString();
                                    emergFeesctrl.text =
                                        _selectedClinic.emergencyFee.toString();
                                  });
                                },
                                items: widget.clinicDoctors
                                    .map<DropdownMenuItem<ClinicDoctor>>(
                                        (ClinicDoctor value) {
                                  return DropdownMenuItem<ClinicDoctor>(
                                    value: value,
                                    child: value != null
                                        ? Text(value.clinic.name,
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600))
                                        : Text(''),
                                  );
                                }).toList(),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Form(
                              key: _formKeyFees,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: opdFeesctrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "OPD Fees",
                                            labelText: "OPD Fees",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.attach_money,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          setState(() {
                                            opdFees = int.parse(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32),
                                    child: Material(
                                      elevation: 2.0,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: emergFeesctrl,
                                        onChanged: (String value) {},
                                        cursorColor: Colors.deepOrange,
                                        decoration: InputDecoration(
                                            hintText: "Emergency Fees",
                                            labelText: "Emergency Fees",
                                            prefixIcon: Material(
                                              elevation: 0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              child: Icon(
                                                Icons.attach_money,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 13)),
                                        onSaved: (value) {
                                          setState(() {
                                            emergFees = int.parse(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      child: RoundedLoadingButton(
                                        controller: _feesbtnController,
                                        color: Colors.orange[700],
                                        child: Text(
                                          "Update Fees",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        onPressed: () {
                                          _validateFeesInputs();
                                        },
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//     context: context,
//     initialDate: dob,
//     firstDate: DateTime(1800),
//     lastDate: DateTime(2080),
//   );
//   if (picked != null && picked != dob)
//     setState(() {
//       dob = picked;
//     });
//   String date = dob.toString();
//   print("date= " + date);
// }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
