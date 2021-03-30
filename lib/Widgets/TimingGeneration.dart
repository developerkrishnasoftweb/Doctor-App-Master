import 'package:fluttertoast/fluttertoast.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Navigation.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/MYProfileModel.dart';
import 'package:getcure_doctor/Models/TimingAddModel.dart';
import 'package:getcure_doctor/Screens/Appointments/Appointment.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimingGeneration extends StatefulWidget {
  final String clinicDoctorId;
  final VoidCallback getdoctors;
  const TimingGeneration({Key key, this.clinicDoctorId, this.getdoctors})
      : super(key: key);

  @override
  _TimingGenerationState createState() => _TimingGenerationState();
}

class _TimingGenerationState extends State<TimingGeneration> {
  DateTime pickedDate;
  String timemon1;
  String timemon2;
  String timetue1;
  String timetue2;
  String timewed1;
  String timewed2;
  String timethu1;
  String timethu2;
  String timefri1;
  String timefri2;
  String timesat1;
  String timesat2;
  String timesun1;
  String timesun2;
  int patmon;
  int pattue;
  int patwed;
  int patthu;
  int patfri;
  int patsun;
  int patsat;
  TextEditingController monController = TextEditingController();
  TextEditingController tueController = TextEditingController();
  TextEditingController wedController = TextEditingController();
  TextEditingController thuController = TextEditingController();
  TextEditingController friController = TextEditingController();
  TextEditingController satController = TextEditingController();
  TextEditingController sunController = TextEditingController();

  MyDoctorProfile profile;

  void getProfile() async {
    profile = await getMyProfileDat();
    setState(() {});
  }

  @override
  void initState() {
    getProfile();
    super.initState();
    pickedDate = DateTime.now();
    timemon1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timemon2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timetue1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timetue2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timewed1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timewed2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timethu1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timethu2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timefri1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timefri2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timesat1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timesat2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timesun1 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    timesun2 = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
  }

  List<String> dayList = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  void allSet(TokenDB database, PatientsDB patientDatabase) {
    Navigator.of(context).pop();
    changeScreenRepacement(
        context,
        Appointments(
          database: database,
          patientDatabase: patientDatabase,
        ));
  }

  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);
    final patientDatabase = Provider.of<PatientsDB>(context);

    return Consumer<Addingtime>(builder: (context, time, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Add Timings"),
            centerTitle: true,
            backgroundColor: orangef,
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 5, left: 5.0),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Monday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null || profile.data == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text('No Previous Timings')
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "monday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day == "monday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isEmpty
                                                ? 0
                                                : profile.data.clinicDoctor
                                                            .where((t) =>
                                                                t.id.toString() ==
                                                                widget
                                                                    .clinicDoctorId)
                                                            .first
                                                            .doctorTimings
                                                            .where((element) =>
                                                                element.day ==
                                                                "monday")
                                                            .first
                                                            .slots
                                                            .length <=
                                                        3
                                                    ? 70
                                                    : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "monday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "monday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? ''
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "monday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "monday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timemon1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timemon1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timemon1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timemon2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timemon2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timemon2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: monController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patmon = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("mon", timemon1.toString(),
                                        timemon2.toString(), patmon);
                                    setState(() {
                                      timemon1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timemon2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patmon = 0;
                                    });
                                    monController.clear();
                                  })
                            ],
                          ),
                          time.mondaydata.length == 0
                              ? Text('')
                              : Text("New Slots"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.mondaydata.length == 0
                                    ? 0
                                    : time.mondaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.mondaydata == null
                                      ? 0
                                      : time.mondaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.mondaydata[index].toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Tuesday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text('No Previous Timings')
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "tuesday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day ==
                                                        "tuesday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isEmpty
                                                ? 0
                                                : profile.data.clinicDoctor
                                                            .where((t) =>
                                                                t.id.toString() ==
                                                                widget
                                                                    .clinicDoctorId)
                                                            .first
                                                            .doctorTimings
                                                            .where((element) =>
                                                                element.day ==
                                                                "tuesday")
                                                            .first
                                                            .slots
                                                            .length <=
                                                        3
                                                    ? 70
                                                    : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "tuesday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "tuesday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? ''
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "tuesday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "tuesday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timetue1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timetue1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timetue1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timetue2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timetue2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timetue2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: tueController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      pattue = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("tue", timetue1.toString(),
                                        timetue2.toString(), pattue);
                                    setState(() {
                                      timetue1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timetue2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      pattue = 0;
                                    });
                                    tueController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.tuesdaydata.length == 0
                                    ? 0
                                    : time.tuesdaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.tuesdaydata == null
                                      ? 0
                                      : time.tuesdaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.tuesdaydata[index].toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Wednesday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text("No Previous Timings")
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "wednesday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day ==
                                                        "wednesday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "wednesday")
                                                        .first
                                                        .slots
                                                        .length <=
                                                    3
                                                ? 70
                                                : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "wednesday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "wednesday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? 0
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "wednesday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "wednesday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timewed1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timewed1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timewed1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timewed2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timewed2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timewed2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: wedController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patwed = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("wed", timewed1.toString(),
                                        timewed2.toString(), patwed);
                                    setState(() {
                                      timewed1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timewed2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patwed = 0;
                                    });
                                    wedController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.wednesdaydata.length == 0
                                    ? 0
                                    : time.wednesdaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.wednesdaydata == null
                                      ? 0
                                      : time.wednesdaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.wednesdaydata[index]
                                                .toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Thursday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text('No Previous Timings')
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "thursday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day ==
                                                        "thursday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "thursday")
                                                        .first
                                                        .slots
                                                        .length <=
                                                    3
                                                ? 70
                                                : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "thursday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "thursday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? 0
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "thursday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "thursday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timethu1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timethu1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timethu1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timethu2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timethu2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timethu2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: thuController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patthu = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("thu", timethu1.toString(),
                                        timethu2.toString(), patthu);
                                    setState(() {
                                      timethu1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timethu2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patthu = 0;
                                    });
                                    thuController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.thusdaydata.length == 0
                                    ? 0
                                    : time.thusdaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.thusdaydata == null
                                      ? 0
                                      : time.thusdaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.thusdaydata[index].toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Friday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text("No Previous Timings")
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "friday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day == "friday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "friday")
                                                        .first
                                                        .slots
                                                        .length <=
                                                    3
                                                ? 70
                                                : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "friday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "friday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? 0
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "friday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "friday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timefri1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timefri1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timefri1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timefri2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timefri2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timefri2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: friController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patfri = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("fri", timefri1.toString(),
                                        timefri2.toString(), patfri);
                                    setState(() {
                                      timefri1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timefri2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patfri = 0;
                                    });
                                    friController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.fridaydata.length == 0
                                    ? 0
                                    : time.fridaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.fridaydata == null
                                      ? 0
                                      : time.fridaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.fridaydata[index].toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Saturday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text("No Previous Timings")
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "saturday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day ==
                                                        "saturday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isEmpty
                                                ? 0
                                                : profile.data.clinicDoctor
                                                            .where((t) =>
                                                                t.id.toString() ==
                                                                widget
                                                                    .clinicDoctorId)
                                                            .first
                                                            .doctorTimings
                                                            .where((element) =>
                                                                element.day ==
                                                                "saturday")
                                                            .first
                                                            .slots
                                                            .length <=
                                                        3
                                                    ? 70
                                                    : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "saturday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "saturday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? 0
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "saturday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "saturday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timesat1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timesat1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timesat1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timesat2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timesat2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timesat2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                // height: 40,
                                child: TextField(
                                  controller: satController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patsat = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("sat", timesat1.toString(),
                                        timesat2.toString(), patsat);
                                    setState(() {
                                      timesat1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timesat2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patsat = 0;
                                    });
                                    satController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.saturdaydata.length == 0
                                    ? 0
                                    : time.saturdaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.saturdaydata == null
                                      ? 0
                                      : time.saturdaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.saturdaydata[index]
                                                .toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    elevation: 10,
                    borderOnForeground: true,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Sunday",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                          ),
                          profile == null
                              ? Text('No Previous Timings')
                              : profile.data.clinicDoctor
                                      .where((t) =>
                                          t.id.toString() ==
                                          widget.clinicDoctorId)
                                      .first
                                      .doctorTimings
                                      .isEmpty
                                  ? Text("No Previous Timings")
                                  : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .where((element) =>
                                                  element.day == "sunday")
                                              .first
                                              .slots
                                              .length ==
                                          0
                                      ? Text('No Previous Timings')
                                      : Text('OldTimings'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Container(
                                height: profile == null
                                    ? 0
                                    : profile.data.clinicDoctor
                                            .where((t) =>
                                                t.id.toString() ==
                                                widget.clinicDoctorId)
                                            .first
                                            .doctorTimings
                                            .isEmpty
                                        ? 0
                                        : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .where((element) =>
                                                        element.day == "sunday")
                                                    .first
                                                    .slots
                                                    .length ==
                                                0
                                            ? 0
                                            : profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isEmpty
                                                ? 0
                                                : profile.data.clinicDoctor
                                                            .where((t) =>
                                                                t.id.toString() ==
                                                                widget
                                                                    .clinicDoctorId)
                                                            .first
                                                            .doctorTimings
                                                            .where((element) =>
                                                                element.day ==
                                                                "sunday")
                                                            .first
                                                            .slots
                                                            .length <=
                                                        3
                                                    ?70
                                                    : 150,
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: profile == null
                                      ? 0
                                      : profile.data.clinicDoctor
                                              .where((t) =>
                                                  t.id.toString() ==
                                                  widget.clinicDoctorId)
                                              .first
                                              .doctorTimings
                                              .isEmpty
                                          ? 0
                                          : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "sunday")
                                                      .first
                                                      .slots ==
                                                  null
                                              ? 0
                                              : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .isEmpty
                                                  ? 0
                                                  : profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "sunday")
                                                      .first
                                                      .slots
                                                      .length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("${index + 1}) " +
                                                (profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .isEmpty
                                                    ? 0
                                                    : profile.data.clinicDoctor
                                                        .where((t) =>
                                                            t.id.toString() ==
                                                            widget
                                                                .clinicDoctorId)
                                                        .first
                                                        .doctorTimings
                                                        .where((element) =>
                                                            element.day ==
                                                            "sunday")
                                                        .first
                                                        .slots[index]
                                                        .toString())),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: red),
                                              onPressed: () {
                                                if (profile.data.clinicDoctor
                                                    .where((t) =>
                                                        t.id.toString() ==
                                                        widget.clinicDoctorId)
                                                    .first
                                                    .doctorTimings
                                                    .isNotEmpty) {
                                                  profile.data.clinicDoctor
                                                      .where((t) =>
                                                          t.id.toString() ==
                                                          widget.clinicDoctorId)
                                                      .first
                                                      .doctorTimings
                                                      .where((element) =>
                                                          element.day ==
                                                          "sunday")
                                                      .first
                                                      .slots
                                                      .removeAt(index);
                                                }

                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Start Time"),
                              Text("End Time"),
                              Text("Patients"),
                              Container()
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timesun1 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timesun1 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("$timesun1"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showTimePicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        setState(() {
                                          timesun2 = DateFormat('HH:mm:ss')
                                              .format(date)
                                              .toString();
                                        });
                                      },
                                      onConfirm: (date) {
                                        timesun2 = DateFormat('HH:mm:ss')
                                            .format(date)
                                            .toString();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text("Time: $timesun2"),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 55,
                                height: 55,
                                child: TextField(
                                  controller: sunController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      patsun = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: red,
                                  ),
                                  onPressed: () {
                                    time.dowork("sun", timesun1.toString(),
                                        timesun2.toString(), patsun);
                                    setState(() {
                                      timesun1 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      timesun2 = DateFormat('hh:mm:ss')
                                          .format(DateTime.now())
                                          .toString();
                                      patsun = 0;
                                    });
                                    sunController.clear();
                                  })
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Container(
                                height: time.sundaydata.length == 0
                                    ? 0
                                    : time.sundaydata.length <= 3
                                        ? 50
                                        : 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: time.sundaydata == null
                                      ? 0
                                      : time.sundaydata.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("${index + 1}) " +
                                            time.sundaydata[index].toString()),
                                      ],
                                    ));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Submit"),
                    color: green,
                    onPressed: () async {
                      setState(() {
                        _isInAsyncCall = true;
                      });
                      print(widget.clinicDoctorId);
                      SendTime st = SendTime(doctorTimings: []);
                      for (int i = 0; i < 7; i++) {
                        TimingGenerationValue tm = TimingGenerationValue(
                          day: dayList[i],
                        );
                        switch (dayList[i]) {
                          case "monday":
                            if (time.mondaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "monday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(tm.slots);
                              }
                            } else {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.mondaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "monday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.mondaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "tuesday":
                            if (time.tuesdaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "tuesday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(tm.slots);
                              }
                            } else {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.tuesdaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "tuesday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.tuesdaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "wednesday":
                            if (time.wednesdaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "wednesday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(tm.slots);
                              }
                            } else {
                               ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.wednesdaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "wednesday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.wednesdaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "thursday":
                            if (time.thusdaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "thursday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(mod);
                              }
                            } else {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.thusdaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "thursday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.thusdaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "friday":
                            if (time.fridaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "friday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(mod);
                              }
                            } else {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.fridaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "friday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.fridaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "saturday":
                            if (time.saturdaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "saturday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(mod);
                              }
                            } else {
                               ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.saturdaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where(
                                        (element) => element.day == "saturday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.saturdaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                          case "sunday":
                            if (time.sundaydata.isEmpty) {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = [];
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "sunday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                print(mod);
                              }
                            } else {
                              ClinicDoctor x = profile.data.clinicDoctor
                                  .where((t) =>
                                      t.id.toString() == widget.clinicDoctorId)
                                  .first;
                              if (x.doctorTimings.isEmpty) {
                                tm.slots = time.sundaydata;
                              } else {
                                List<Slots> mod = x.doctorTimings
                                    .where((element) => element.day == "sunday")
                                    .first
                                    .slots;
                                tm.slots = mod;
                                tm.slots.addAll(time.sundaydata);
                                print(tm.slots);
                              }
                              
                            }

                            break;
                        }
                        st.doctorTimings.add(tm);
                      }
                      print(st.doctorTimings);
                      for (var i in st.doctorTimings) {
                        print(i.day);
                        print(i.slots.toString());
                      }
                      
                      bool check =
                          await doctorTimings(st, widget.clinicDoctorId);
                      if (check) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.reload();
                        setState(() {
                          _isInAsyncCall = false;
                        });

                        widget.getdoctors();
                        Fluttertoast.showToast(
                                msg: "Timings updated",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: green,
                                textColor: black,
                                fontSize: 16.0)
                            .then((value) => allSet(database, patientDatabase));
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
                        setState(() {
                          _isInAsyncCall = false;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ));
    });
  }
}

class DataSetting {
  String starttime;
  String endtime;
  String patientno;

  DataSetting({this.starttime, this.endtime, this.patientno});
}

class Addingtime with ChangeNotifier {
  List<Slots> mondaydata = [];
  List<Slots> tuesdaydata = [];
  List<Slots> wednesdaydata = [];
  List<Slots> thusdaydata = [];
  List<Slots> fridaydata = [];
  List<Slots> saturdaydata = [];
  List<Slots> sundaydata = [];
  void dowork(String day, String startTime, String endTime, int patients) {
    Slots ds =
        Slots(startTime: startTime, endTime: endTime, noOfPatients: patients);
    switch (day) {
      case "mon":
        mondaydata.add(ds);
        break;
      case "tue":
        tuesdaydata.add(ds);
        break;
      case "wed":
        wednesdaydata.add(ds);
        break;
      case "thu":
        thusdaydata.add(ds);
        break;
      case "fri":
        fridaydata.add(ds);
        break;
      case "sat":
        saturdaydata.add(ds);
        break;
      case "sun":
        sundaydata.add(ds);
        break;
    }
    notifyListeners();
  }
}

class TimingsUpdateForResponseModel {
  ClinicDoctor data;

  TimingsUpdateForResponseModel({this.data});

  TimingsUpdateForResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ClinicDoctor.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
