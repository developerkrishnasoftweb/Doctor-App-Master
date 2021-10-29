import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Apis.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/ImageDataModel.dart';
import 'package:getcure_doctor/Models/SpecialitySearchSuggestion.dart';
import 'package:getcure_doctor/Models/StateSearchSuggestion.dart';
import 'package:getcure_doctor/Screens/Appointments/Appointment.dart';
import 'package:getcure_doctor/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helpers/AppConfig/colors.dart';
import '../../Helpers/Navigation.dart';
import 'ClinicDetails.dart';
import 'CreateProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class CompleteProfile extends StatefulWidget {
  CompleteProfile({Key key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  bool _isLoading = true;
  File _image;
  final picker = ImagePicker();
  Dio dio = new Dio();
  SendImageDataModel sendThis = SendImageDataModel(identityVerificationUrl: []);

  @override
  void initState() {
    super.initState();
    getSuggestions();
  }

  List<StateData> suggestions = [];

  getSuggestions() async {
    List<StateData> suggestion = await getStateinfo();
    List<SpecialityData> ss = await getSpeciality();
    setState(() {
      suggestions = suggestion;
      suggestionspeci = ss;
    });
  }

  List<SpecialityData> suggestionspeci = [];

  chooseimage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    print(_image);
  }

  startupload(File imageFile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("signtoken");
    try {
      String filename = _image.path.split('/').last;
      FormData formdata = new FormData.fromMap({
        "image": await MultipartFile.fromFile(_image.path,
            filename: filename, contentType: new MediaType('image', 'png')),
      });
      Response response = await dio.post(IMAGEDOCUPLOAD + "id_verification",
          data: formdata,
          options: Options(headers: {
            "Authorization": token,
          }));

      print(response.statusCode);
      var data = jsonDecode(response.toString());
      ImageDataModel imageUrl = ImageDataModel.fromJson(data);
      IdentityVerificationUrl addThis =
          IdentityVerificationUrl(type: "id_verification", url: imageUrl.data);
      if (sendThis.identityVerificationUrl.isEmpty) {
        sendThis.identityVerificationUrl.add(addThis);
      } else {
        sendThis.identityVerificationUrl[0] = addThis;
      }

      print(data);
    } catch (e) {
      print(e);
    }
  }

  startuploadClinicOwnership(File imageFile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("signtoken");
    try {
      String filename = _image.path.split('/').last;
      FormData formdata = new FormData.fromMap({
        "image": await MultipartFile.fromFile(_image.path,
            filename: filename, contentType: new MediaType('image', 'png')),
      });
      Response response = await dio.post(IMAGEDOCUPLOAD + "clinic_ownership",
          data: formdata,
          options: Options(headers: {
            "Authorization": token,
          }));

      print(response.statusCode);
      var data = jsonDecode(response.toString());
      ImageDataModel imageUrl = ImageDataModel.fromJson(data);
      IdentityVerificationUrl addThis =
          IdentityVerificationUrl(type: "clinic_ownership", url: imageUrl.data);
      if (sendThis.identityVerificationUrl.length == 1) {
        sendThis.identityVerificationUrl.add(addThis);
      } else {
        sendThis.identityVerificationUrl[1] = addThis;
      }

      print(data);
    } catch (e) {
      print(e);
    }
  }

  int currentStep = 0;

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        stops: [0.5, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          pcolor,
                          orangef,
                        ]),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(
                            Icons.touch_app,
                            size: 25.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            changeScreen(context, Appointments());
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, left: 10.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(
                            'You are 1 step away from completing your profile',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: _mainListBuilder,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0)
      return Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          child: Text(
            "Steps",
          ));
    return _buildMainItem(context);
  }

  Widget _buildMainItem(BuildContext context) {
    return Container(
      child: Stepper(
        physics: ClampingScrollPhysics(),
        currentStep: currentStep,
        steps: [
          Step(
            title: Text('YOUR PROFILE'),
            content: Text(''),
            isActive: true,
          ),
          Step(title: Text('CLINIC'), content: Text(''), isActive: true),
          Step(
              title: Text('UPLOAD DOCUMENTS'),
              content: Container(
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: 'Submit a photo ID for Verification\n',
                            style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                            text:
                                'This is to verify that you are who you say you are.Example: Passport, AadharUID, Pan Card, Election Commision Card, DL, Ration Card with photo\n',
                            style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ])),
                    Container(
                      child: Center(
                        child: _isLoading
                            ? Container()
                            : Container(
                                height: 80,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(_image),
                                ),
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          FlatButton(
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  color: orangep,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: chooseimage),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          FlatButton(
                            //onPressed: startupload,
                            child: Text('Upload',
                                style: TextStyle(
                                  color: orangef,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              startupload(_image);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: 'Submit Clinic ownership document\n',
                            style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                          TextSpan(
                            text:
                                'This is to verify that you are are registered healthcare professional.Example: Clinic letter head/prescription pad stating you are the clinic owner with your signature, Clinic Registration Proof, Document for waste disposal, Sales tax receipt for clinic\n',
                            style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ])),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          FlatButton(
                              child: Text(
                                'Select',
                                style: TextStyle(
                                  color: orangep,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: chooseimage),
                          FlatButton(
                            onPressed: () {
                              startuploadClinicOwnership(_image);
                            },
                            child: Text('Upload',
                                style: TextStyle(
                                  color: orangef,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              state: StepState.editing,
              isActive: true),
        ],
        type: StepperType.vertical,
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepCancel: () {
          setState(() {
            if (currentStep > 0) {
              currentStep = currentStep - 1;
            } else {
              currentStep = 0;
            }
          });
        },
        onStepContinue: () async {
          switch (currentStep) {
            case 0:
              changeScreen(
                  context,
                  CreateProfile(
                      suggestionsstate: suggestions,
                      suggestionspec: suggestionspeci));
              setState(() {
                currentStep += 1;
              });
              break;
            case 1:
              changeScreen(context, ClinicDetails(states: suggestions));
              setState(() {
                currentStep += 1;
              });
              break;
            case 2:
              // print(sendThis.toJson());
              // print(json.encode(sendThis.toJson()['identity_verification_url']));
              bool result = await sendImagesUrl(sendThis);
              if (result == true) {
                Fluttertoast.showToast(
                    msg: "Profile Created\nPlease Login ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: green,
                    textColor: black,
                    fontSize: 16.0);
                changeScreenRepacement(context, LoginPage());
              } else {
                Fluttertoast.showToast(
                    msg: "Some error Occured",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: red,
                    textColor: black,
                    fontSize: 16.0);
              }
              // AlertDialog();
              // setState(() {
              //   currentStep = 0;
              // });
              break;
            default:
              changeScreen(context, CreateProfile());
              setState(() {
                currentStep += 1;
              });
              break;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}

// List<Step> mySteps = [
//   Step(
//     title: Text('YOUR PROFILE'),
//     content: Text(''),
//     isActive: true,
//   ),
//   Step(title: Text('CLINIC'), content: Text(''), isActive: true),
//   Step(
//       title: Text('UPLOAD DOCUMENTS'),
//       content: Container(
//         child: Column(
//           children: <Widget>[
//             RichText(
//                 text: TextSpan(
//                     text: 'Submit a photo ID for Verification\n',
//                     style: TextStyle(
//                         color: black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                     children: <TextSpan>[
//                   TextSpan(
//                     text:
//                         'This is to verify that you are who you say you are.Example: Passport, AadharUID, Pan Card, Election Commision Card, DL, Ration Card with photo\n',
//                     style: TextStyle(
//                         color: black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w300),
//                   ),
//                 ])),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Row(
//                 children: [
//                   FlatButton(
//                     child: Text(
//                       'Select',
//                       style: TextStyle(
//                         color: orangep,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onPressed: (){}
//                   ),
//                   Padding(padding: EdgeInsets.only(left: 15)),
//                   FlatButton(
//                     //onPressed: startupload,
//                     child: Text('Upload',
//                         style: TextStyle(
//                           color: orangef,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         )),
//                         onPressed: (){},
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),
//             RichText(
//                 text: TextSpan(
//                     text: 'Submit Clinic ownership document\n',
//                     style: TextStyle(
//                         color: black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                     children: <TextSpan>[
//                   TextSpan(
//                     text:
//                         'This is to verify that you are are registered healthcare professional.Example: Clinic letter head/prescription pad stating you are the clinic owner with your signature, Clinic Registration Proof, Document for waste disposal, Sales tax receipt for clinic\n',
//                     style: TextStyle(
//                         color: black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w300),
//                   ),
//                 ])),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: FlatButton(
//                 onPressed: () {
//                   //getImage();
//                 },
//                 child: Text('Upload',
//                     style: TextStyle(
//                       color: orangef,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//       state: StepState.editing,
//       isActive: true),
// ];
