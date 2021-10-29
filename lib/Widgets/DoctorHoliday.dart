import 'dart:convert';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/MYProfileModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart' as dclo;
import 'package:getcure_doctor/Models/SendHolidayUpdateModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorHolidays extends StatefulWidget {
  //final FrontDocData frontDocData;
  final int docId;
  final List<ClinicDoctor> clinicDoctor;
  const DoctorHolidays({Key key, this.docId, this.clinicDoctor})
      : super(key: key);

  @override
  _DoctorHolidaysState createState() => _DoctorHolidaysState();
}

class _DoctorHolidaysState extends State<DoctorHolidays> {
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 10000)),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controller.text =
            DateFormat("yyyy-MM-dd").format(selectedDate).toString();
      });
    String date = selectedDate.toString();
    //print("date= " + date);
  }

  // ClinicDoctor dropdownvalue;
  // List<ClinicDoctor> doc = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      // doc = widget.clinicDoctor;
      // dropdownvalue = doc[0];
      selectedDate = DateTime.now();
    });
  }

  bool _isInAsyncCall = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // print(h);
    return Consumer<Holiday>(
      builder: (context, hol, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: white,
            ),
            centerTitle: true,
            title: Text('Doctor Holidays'),
            backgroundColor: orangef,
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: DropdownButton<ClinicDoctor>(
                    //     value: dropdownvalue == null ? null : dropdownvalue,
                    //     hint: Text("Select Clinic"),
                    //     elevation: 16,
                    //     style: TextStyle(color: black),
                    //     onChanged: (ClinicDoctor newValue) {
                    //       setState(() {
                    //         dropdownvalue = newValue;
                    //         });
                    //     },
                    //     items: doc.map<DropdownMenuItem<ClinicDoctor>>(
                    //               (ClinicDoctor value) {
                    //             return DropdownMenuItem<ClinicDoctor>(
                    //               value: value,
                    //               child: value != null
                    //                   ? Text(
                    //                       value.clinic.name,
                    //                     )
                    //                   : Text(''),
                    //             );
                    //           }).toList(),
                    //   ),
                    // ),
                    Text(
                      'Add Holiday dates',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Select date:',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: pcolor,
                                  )),
                            ),
                          ],
                        ),
                        Container(
                            width: 100.0,
                            child: TextFormField(
                              controller: controller,
                              enabled: false,
                            )),
                        IconButton(
                            icon: Icon(Icons.add, color: red),
                            onPressed: () {
                              if (!hol.holi.contains(DateFormat("yyyy-MM-dd")
                                  .format(selectedDate)
                                  .toString())) {
                                hol.doWork(DateFormat("yyyy-MM-dd")
                                    .format(selectedDate)
                                    .toString());
                                controller.clear();
                              }

                              print(hol.holi);
                            }),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Selected dates',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: hol.holi == null ? 0 : hol.holi.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: Column(
                                children: [
                                  Text("${index + 1}) " + hol.holi[index]),
                                ],
                              ));
                        },
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                          color: green,
                          child: Text(
                            "Add Holidays",
                            style: TextStyle(color: white),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isInAsyncCall = true;
                            });
                            MyDoctorProfile dopa = await getMyProfileDat();
                            List<String> hoe = dopa.data.holidays;
                            hoe.addAll(hol.holi);
                            DocHoli ans = DocHoli(holidays: hoe);
                            bool check = await sendHolidays(ans, widget.docId);
                            if (check) {
                              setState(() {
                                hol.holi.clear();
                                ans.holidays.clear();
                                _isInAsyncCall = false;
                              });
                              docinfo();
                              Fluttertoast.showToast(
                                  msg: "Holidays updated",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: green,
                                  textColor: black,
                                  fontSize: 16.0);
                              setState(() {});
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
                          }),
                    ),
                    Text(
                      'Current Holiday dates',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 100.0,
                          maxHeight: h > 640 ? 400 : h * 0.45,
                        ),
                        child: FutureBuilder(
                          future: docinfo(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                                break;
                              case ConnectionState.done:
                                if (snapshot.data == null) {
                                  return Container(
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                          "No Holidays",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  );
                                } else {
                                  return ListView.builder(
                                      physics: ScrollPhysics(),
                                      itemCount: snapshot.data == null
                                          ? 0
                                          : snapshot.data.holidays.length,
                                      itemBuilder: (context, index) {
                                        print(snapshot.data.holidays);
                                        snapshot.data.holidays.sort();
                                        final item =
                                        snapshot.data.holidays[index];
                                        return ListTile(
                                            title: Text("Date"),
                                            subtitle: Text(DateFormat(
                                                'dd-MM-yyyy')
                                                .format((DateTime.parse(item)))
                                                .toString()),
                                            trailing: IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: red,
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    _isInAsyncCall = true;
                                                  });
                                                  print(snapshot.data.holidays);
                                                  setState(() {
                                                    snapshot.data.holidays
                                                        .removeAt(index);
                                                  });
                                                  print(snapshot.data.holidays);
                                                  DocHoli ans = DocHoli(
                                                      holidays: snapshot
                                                          .data.holidays);
                                                  bool check =
                                                  await sendHolidays(
                                                      ans, widget.docId);
                                                  if (check) {
                                                    SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                    SenHolidayUpdateModel
                                                    docData =
                                                    SenHolidayUpdateModel(
                                                        data:
                                                        snapshot.data);
                                                    pref.setString(
                                                        'docDataResponse',
                                                        json.encode(
                                                            docData.data));
                                                    pref.reload();
                                                    setState(() {
                                                      _isInAsyncCall = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg: "Holidays updated",
                                                        toastLength:
                                                        Toast.LENGTH_SHORT,
                                                        gravity:
                                                        ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: green,
                                                        textColor: black,
                                                        fontSize: 16.0);
                                                  } else {
                                                    setState(() {
                                                      _isInAsyncCall = false;
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg:
                                                        "Some error Occured",
                                                        toastLength:
                                                        Toast.LENGTH_SHORT,
                                                        gravity:
                                                        ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: red,
                                                        textColor: black,
                                                        fontSize: 16.0);
                                                  }
                                                }));
                                      });
                                }
                                break;
                              default:
                                return Center(
                                    child: Text(
                                      "Something went Wrong",
                                      style: TextStyle(color: red),
                                    ));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Holiday extends ChangeNotifier {
  List<String> holi = [];

  void doWork(String date) {
    this.holi.add(date);
    notifyListeners();
  }
}

class DocHoli {
  List<String> holidays;

  DocHoli({this.holidays});

  DocHoli.fromJson(Map<String, dynamic> json) {
    holidays = json['holidays'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holidays'] = this.holidays;
    return data;
  }
}
