import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Widgets/FeedBackScreen.dart';
import 'package:getcure_doctor/Widgets/PatientVisitDialog.dart';
import 'package:getcure_doctor/Widgets/SearchAllergy.dart';
import 'package:getcure_doctor/Widgets/SearchBar.dart';
import 'package:getcure_doctor/Widgets/SearchLifeStyle.dart';
import 'package:getcure_doctor/Widgets/searchBarVisit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

class Symtoms extends StatefulWidget {
  final Token token;
  final int clinicDocId;
  final List<PatientsVisitData> pd;
  
  Symtoms({Key key, this.token, this.clinicDocId, this.pd }) : super(key: key);

  @override
  _SymtomsState createState() => _SymtomsState();
}

class _SymtomsState extends State<Symtoms> {
  var imageUrl;
  bool isloading = false;
  bool showResponse = false;
  String error = '';
  final picker = ImagePicker();

  String query = '';
  Future uploadImage() async {
    const url = "";
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        isloading = true;
      });
    }

    if (image != null) {
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          contentType: new MediaType("image", "jpg"),
        ),
        // "upload_preset": "project78",
        // "cloud_name": "dcsqiv7je",
      });
      try {
        Response response = await Dio().post(url, data: formData);
        var data = jsonDecode(response.toString());
        print(response.data);
        print(data['secure_url']);

        setState(() {
          isloading = false;
          imageUrl = data['secure_url'];
          print(imageUrl);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // Future<SymptomsModel> fetchBriefHistoryList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   final response = await http.get(
  //     GETBRIEFHISTORY,
  //     headers: {"Authorization": token},
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     SymptomsModel briefHistory =
  //         SymptomsModel.fromJson(json.decode(response.body));
  //     return briefHistory;
  //   } else {
  //     throw Exception('Unable to fetch invoice');
  //   }
  // }

  // void getlist() async {
  //  SymptomsModel mod = await fetchBriefHistoryList();
  //   for (int index = 0; index < mod.data.length; index++)
  //     _selectedAddItemsDoctors[index].name = mod.data[index].values;
  // }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientsVisitDB>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: <Widget>[
          ExpansionTile(
              initiallyExpanded: true,
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(FontAwesome.clock_o),
                        onPressed: () {
                          
                          showDialog(
                              context: context,
                              builder: (_) {
                                return PatientVisitDialog(
                                    token: widget.token, pat: patient,pd: widget.pd);
                              });
                        }),
                    Text(
                      'Brief History',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.local_hospital,
                          color: orange,
//
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SearchBar(

                                  pId: widget.token.guid,
                                  clinicDocID: widget.clinicDocId,
                                  docId: widget.token.doctorid);
                            },
                          );
                        }),
                  ],
                ),
              ),
              children: [
                StreamBuilder(
                  stream: patient.getBriefHistory(widget.token.guid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PatientsVisitData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading");
                        break;
                      default:
                        return ListView.builder(
                          itemCount: snapshot.data.last.briefHistory == null
                              ? 0
                              : snapshot.data.last.briefHistory.data.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              dense: true,
                              title: Text(
                                snapshot
                                    .data.last.briefHistory.data[index].title,
                                // style: TextStyle(
                                //     color: snapshot.data.last.briefHistory
                                //                 .data[index].isCured ==
                                //             true
                                //         ? green
                                //         : red),
                              ),
                              subtitle: Text(
                                  "${snapshot.data.last.briefHistory.data[index].isCured == true ? "Cured" : "Since"} (${snapshot.data.last.briefHistory.data[index].date})",
                                  style: TextStyle(
                                      color: snapshot.data.last.briefHistory
                                                  .data[index].isCured ==
                                              true
                                          ? green
                                          : red)),
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Are you sure you want to remove it?"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Yes"),
                                              color: red,
                                              onPressed: () {
                                                patient.deleteBrief(
                                                    snapshot.data.last,
                                                    snapshot
                                                        .data
                                                        .last
                                                        .briefHistory
                                                        .data[index]
                                                        .title);
                                                patient.deleteDiagnosis(
                                                    snapshot.data.last,
                                                    snapshot.data.last.diagnosis
                                                        .data[index].title);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              color: green,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            );
                          },
                        );

                        break;
                      // default:
                      //   return Text('NO Data');
                      //   break;
                    }
                  },
                ),
              ]),
          ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Today's Visit Reasons",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.local_hospital,
                        color: orange,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SearchBarVisit(
                              pId: widget.token.guid,
                              docId: widget.token.doctorid,
                              clinicDocId: widget.clinicDocId,
                            );
                          },
                        );
                      }),
                ],
              ),
              children: [
                StreamBuilder(
                  stream: patient.getVisitReason(widget.token.guid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PatientsVisitData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading");
                        break;
                      default:
                        return ListView.builder(
                          itemCount: snapshot.data.last.visitReason == null
                              ? 0
                              : snapshot.data.last.visitReason.data.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              title: Text(
                                snapshot
                                    .data.last.visitReason.data[index].title,
                              ),
                              subtitle: Text(
                                  "${snapshot.data.last.visitReason.data[index].isCured == true ? "Cured" : "Since"} (${snapshot.data.last.visitReason.data[index].date})",
                                  style: TextStyle(
                                      color: snapshot.data.last.visitReason
                                                  .data[index].isCured ==
                                              true
                                          ? green
                                          : red)),
                              dense: true,
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Are you sure you want to remove it?"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Yes"),
                                              color: red,
                                              onPressed: () {
                                                patient.deleteVisit(
                                                    snapshot.data.last,
                                                    snapshot
                                                        .data
                                                        .last
                                                        .visitReason
                                                        .data[index]
                                                        .title);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              color: green,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                              onTap: () {
                                if (snapshot.data.last.feedBack == null ||
                                    snapshot.data.last.feedBack.data.length ==
                                        0) {
                                  print(snapshot.data.last.feedBack);
                                  Fluttertoast.showToast(
                                      msg: "No pending feedback",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: green,
                                      textColor: white,
                                      fontSize: 16.0);
                                } else {
                                  print(snapshot
                                      .data.last.feedBack.data[0].disease);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FeedBackScreen(
                                        token: widget.token,
                                        pat: snapshot.data.last,
                                        patient: patient,
                                        context: context,
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                        );
                        break;
                    }
                  },
                ),
              ]),
          ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Allergies",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.local_hospital,
                        color: orange,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SearchAllergy(
                              pId: widget.token.guid,
                              docId: widget.token.doctorid,
                            );
                          },
                        );
                      }),
                ],
              ),
              children: [
                StreamBuilder(
                  stream: patient.getAllergies(widget.token.guid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PatientsVisitData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading");
                        break;
                      default:
                        return ListView.builder(
                          itemCount: snapshot.data.last.allergies == null
                              ? 0
                              : snapshot.data.last.allergies.data.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(snapshot
                                  .data.last.allergies.data[index].title),
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Are you sure you want to remove it?"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Yes"),
                                              color: red,
                                              onPressed: () {
                                                patient.deleteallergy(
                                                    snapshot.data.last,
                                                    snapshot.data.last.allergies
                                                        .data[index].title);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              color: green,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            );
                          },
                        );

                        break;
                    }
                  },
                ),
              ]),
          ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "LifeStyle",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.local_hospital,
                        color: orange,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SearchLifeStyle(
                              pId: widget.token.guid,
                              docId: widget.token.doctorid,
                            );
                          },
                        );
                      }),
                ],
              ),
              children: [
                StreamBuilder(
                  stream: patient.getLifeStyle(widget.token.guid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PatientsVisitData>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading");
                        break;
                      default:
                        return ListView.builder(
                          itemCount: snapshot.data.last.lifestyle == null
                              ? 0
                              : snapshot.data.last.lifestyle.data.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(snapshot
                                  .data.last.lifestyle.data[index].title),
                              trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Are you sure you want to remove it?"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Yes"),
                                              color: red,
                                              onPressed: () {
                                                patient.deleteLifeStyle(
                                                    snapshot.data.last,
                                                    snapshot.data.last.lifestyle
                                                        .data[index].title);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              color: green,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            );
                          },
                        );

                        break;
                      // default:
                      //   return Text('NO Data');
                      //   break;
                    }
                  },
                ),
              ]),
        ],
      ))),
    );
  }
}
