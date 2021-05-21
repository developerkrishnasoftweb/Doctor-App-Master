import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/ExaminationTable.dart';
import 'package:getcure_doctor/Database/FeedBackTable.dart';
import 'package:getcure_doctor/Database/HabitsTable.dart';
import 'package:getcure_doctor/Database/MedicinesTable.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/SymptomsTable.dart';
import 'package:getcure_doctor/Helpers/Network/DataSyncFunctions.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Logic/GenerateTokens.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Widgets/Drawer.dart';
import 'package:getcure_doctor/Widgets/dataTable.dart';
import 'package:getcure_doctor/Widgets/iconsloading.dart';
import 'package:getcure_doctor/Widgets/slots.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';

class Appointments extends StatefulWidget {
  final TokenDB database;
  final PatientsDB patientDatabase;
  const Appointments({this.database, this.patientDatabase});
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<ClinicDoctor> doc = [ClinicDoctor(clinic: Clinic(name: ""))];
  DoctorLoginData docUser;
  Token tokens;
  String query = '';

  Timer T;
  List<ClinicDoctor> dropdown = [];
  getdoctors() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.reload();
    String doctors = pref.getString('docDataResponse');
    docUser = DoctorLoginData.fromJson(json.decode(doctors));
    for (var i in docUser.clinicDoctor) {
      if (!dropdown.contains(i)) {
        setState(() {
          dropdown.add(i);
        });
      }
    }
    setState(() {
      _selecteddoc = dropdown.first;
      counting(widget.database);
    });
    // dropdownvalue = frontDeskUser.data.clinicDoctors[0];
    // for (int i = 0; i < docUser.data.length; i++) {
    //   setState(() {
    //     doc.add(docUser.data[i]);
    //   });
    // }
    //
  }

  void callOnTimingsUpdate() {
    widget.database.deleteallTask();
    getdoctors();
  }

  GenerateTokens token = GenerateTokens();

  generate(TokenDB database) {
    BuildContext context;
    token.tokens = GeneratedTokens(
        fees: _selecteddoc.consultationFee,
        doctorid: _selecteddoc.id,
        date: datePicked,
        clinicId: _selecteddoc.clinicId,
        // starttime: DateTime.parse("10:00:00"), //timee(datePicked, 'startTime'),
        // startbreaktime:
        //     DateTime.parse("13:00:00"), // timee(datePicked, 'breakStart'),
        // endbreaktime:
        //     DateTime.parse("14:00:00"), //timee(datePicked, 'breakEnd'),
        // endtime: DateTime.parse("20:00:00"), //timee(datePicked, 'endTime'),
        slots: timee(datePicked).slots,
        nfp: 15);
    token.generateToken(context, database);
  }

  DoctorTimings timee(DateTime selecteddate) {
    dynamic s = DateFormat('EEEE').format(selecteddate);
    DateTime p;
    s = s.toString().toUpperCase();
    // return _selecteddoc.doctorTimings.where((element) => element.day.toUpperCase().compareTo(s)==0);
    for (var i in _selecteddoc.doctorTimings) {
      // print(i.day);
      if (i.day.toUpperCase().compareTo(s) == 0) {
        // print(i.day+"hello how are you");
        return i;
      }
    }
    // return _selecteddoc.doctorTimings[0];
    // for (var i in _selecteddoc.doctorTimings) {
    //   var o;
    //   if (s.toString().compareTo(i.day.toUpperCase()) == 0) {
    //     switch (t) {
    //       case "startTime":
    //         o = i.startTime;
    //         break;
    //       case "endTime":
    //         o = i.endTime;
    //         break;
    //       case "breakStart":
    //         o = i.breakStart;
    //         break;
    //       default:
    //         o = i.breakEnd;
    //     }
    //     String e = DateFormat("yyyy-MM-dd").format(selecteddate) + " " + o;
    //     p = DateTime.parse(e);
    //   }
    // }
    // return p;
  }

  var countRows;
  var countoncall;
  var countonfront;
  var countOnline;
  var countPresent;
  var countComplete;

  @override
  void initState() {
    // clinicDoctors();
    getdoctors();
    const oneSec = const Duration(seconds: 5);
    T = Timer.periodic(oneSec, (Timer t) => tokenfetch());
    counting(widget.database);
    super.initState();
    // docId = tokens.doctorid;
  }

  int docId = 0;
  @override
  void dispose() {
    T.cancel();
    super.dispose();
  }

  tokenfetch() async {
    // print(dropdownvalue.id);
    dynamic li = await widget.database.getAllTasks(datePicked, _selecteddoc.id);
    if (li.length != 0) {
      getTokens(datePicked, widget.database, _selecteddoc.id.toString(),
          widget.patientDatabase, context);
    } else {
      generate(widget.database);
    }
    counting(widget.database);
  }

  void counting(TokenDB x) async {
    List<Token> countRowslist = await x.getcount(datePicked);
    countRows = countRowslist.length;
    countRowslist = await x.getcountoncall(datePicked);
    countoncall = countRowslist.length;
    countRowslist = await x.getcountonfront(datePicked);
    countonfront = countRowslist.length;
    countRowslist = await x.getcountOnline(datePicked);
    countOnline = countRowslist.length;
    countRowslist = await x.getcountPresent(datePicked);
    countPresent = countRowslist.length;
    countRowslist = await x.getcountCompleted(datePicked);
    countComplete = countRowslist.length;
    setState(() {
      countRows = countRows;
      countoncall = countoncall;
      countonfront = countonfront;
      countOnline = countOnline;
      countPresent = countPresent;
      countComplete = countComplete;
    });
  }
  bool _isInAsyncCall = false;
  ClinicDoctor _selecteddoc;
  //ClinicDoctor dropdownvalue = ClinicDoctor(doctorName: '');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var datePicked = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<PatientsDB>(context);
    final pv = Provider.of<PatientsVisitDB>(context);
    final edb = Provider.of<ExaminationsDB>(context);
    final mdb = Provider.of<MedicinesDB>(context);
    final hdb = Provider.of<HabitDB>(context);
    final fdb = Provider.of<FeedBackDB>(context);
    final sdb = Provider.of<SymptomsDB>(context);
    final tdb = Provider.of<TokenDB>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        name: _selecteddoc == null ? " " : _selecteddoc.doctorName,
        id: _selecteddoc == null ? "" : _selecteddoc.id.toString(),
        clinicid: _selecteddoc == null ? "" : _selecteddoc.clinicId.toString(),
        docId: _selecteddoc == null ? 0 : _selecteddoc.doctorId,
        clinicDoctor: dropdown,
        date: datePicked,
        getDoctors: callOnTimingsUpdate,
        clinicDocId:  _selecteddoc == null ? 0 : _selecteddoc.id,
        docUser: docUser,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: orangef,
        ),
        backgroundColor: white,
        title: Center(
          child: dropdown.isEmpty
              ? Container()
              : dropdown.length > 1
                  ? DropdownButton(
                      value: _selecteddoc,
                      hint: Text('Select Clinic'),
                      elevation: 16,
                      style: TextStyle(color: black),
                      onChanged: (newValue) {
                        setState(() {
                          _selecteddoc = newValue;
                        });
                        counting(widget.database);
                      },
                      items: dropdown.map((ClinicDoctor val) {
                        return DropdownMenuItem(
                          child: Text(val.clinic.name),
                          value: val,
                        );
                      }).toList(),
                    )
                  : Text(
                      dropdown.first.clinic.name,
                      style: TextStyle(color: black, fontSize: 15.0),
                    ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                // mdb.deleteallTask();
                syncCancelled(widget.database, _selecteddoc.id);
                syncParameters(_selecteddoc.doctorId.toString());
                // fetchParameters(_selecteddoc.doctorId.toString());
                // fetchCancelledTokens(_selecteddoc.id.toString(),datePicked,widget.database,_selecteddoc.clinicId);
                // fetchExamination(_selecteddoc.doctorId.toString(), edb);
                // fetchMedication(_selecteddoc.doctorId.toString(), mdb);
                // fetchData(_selecteddoc.doctorId, sdb);
                // fetchHabits(_selecteddoc.doctorId.toString(), hdb);
                // fetchFeedback(_selecteddoc.id.toString(), fdb,_selecteddoc.doctorId);
                // fetchPatientsVisit(_selecteddoc.id.toString(), pv);
                // fetchPatients(_selecteddoc.id.toString(),p);
              }),
          IconButton(
              icon: Icon(Icons.accessibility),
              onPressed: () {
                // syncCancelled(widget.database,_selecteddoc.id );
                // // tokenfetch()
                // syncParameters(_selecteddoc.doctorId.toString());
                fetchParameters(_selecteddoc.doctorId.toString());
                fetchCancelledTokens(_selecteddoc.id.toString(), datePicked,
                    widget.database, _selecteddoc.clinicId);
                fetchExamination(_selecteddoc.doctorId.toString(), edb);
                fetchMedication(_selecteddoc.doctorId.toString(), mdb);
                fetchData(_selecteddoc.doctorId, sdb,_selecteddoc.id);
                fetchHabits(_selecteddoc.doctorId.toString(), hdb);
                fetchFeedback(
                    _selecteddoc.id.toString(), fdb, _selecteddoc.doctorId);
                fetchPatientsVisit(_selecteddoc.id.toString(), pv);
                fetchPatients(_selecteddoc.id.toString(), p);
              }),
          IconButton(
            icon: Icon(
              Icons.sync,
              color: pcolor,
              size: 30,
            ),
            onPressed: () async {
              // syncPatient(p, widget.database, pv);
              setState(() {
                _isInAsyncCall=true;
              });
              getAdvices(context);
              syncPatient(p, widget.database, pv).then((res) {
                if (res) {
                  syncPatientVisit(pv).then((pvr) async {
                    if (pvr) {
                      var se = await syncExamination(edb);
                      var sh = await syncHabit(hdb);
                      var ss = await syncSymptom(sdb);
                      var sm = await syncMedicines(mdb);
                      var sf = await syncFeedBack(fdb);
                      var tf = await syncTokens(tdb, _selecteddoc.id);
                      if (se && sh && ss && sm && sf && tf) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Data Sync completed Successfully !!',
                            style: TextStyle(color: white),
                          ),
                          backgroundColor: green,
                          duration: Duration(seconds: 5),
                        ));
                        setState(() {
                          _isInAsyncCall=false;
                        });
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Something Went Wrong!! Please Try Again Later',
                            style: TextStyle(color: white),
                          ),
                          backgroundColor: red,
                          duration: Duration(seconds: 5),
                        ));
                        setState(() {
                          _isInAsyncCall=false;
                        });
                      }
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          'Something Went Wrong!! Please Try Again Later',
                          style: TextStyle(color: white),
                        ),
                        backgroundColor: red,
                        duration: Duration(seconds: 5),
                      ));
                      setState(() {
                          _isInAsyncCall=false;
                      });
                    }
                  });
                } else {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(
                      'Something Went Wrong!! Please Try Again Later',
                      style: TextStyle(color: white),
                    ),
                    backgroundColor: red,
                    duration: Duration(seconds: 5),
                  ));
                  setState(() {
                    _isInAsyncCall=false;
                  });
                }
              });
              // await widget.patientDatabase.deleteallTask();
            },
          ),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
                  child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 17.0,
                        left: 90.0,
                        child: Container(
                          height: 30,
                          width: 180,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: orangep, width: 2.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 0),
                            child: FittedBox(
                              fit:BoxFit.scaleDown,
                                                          child: Center(
                                  child: Text(
                                'Dr.' +
                                    (_selecteddoc == null
                                        ? " "
                                        : _selecteddoc.doctorName),
                                style: TextStyle(color: black, fontSize: 19),
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 38.0,
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: orangep)),
                          child: Center(
                              child: CircleAvatar(
                                  backgroundImage:docUser!=null&& docUser.imageUrl !=
                                          null
                                      ? NetworkImage(
                                          docUser.imageUrl)
                                      : NetworkImage(
                                          "https://img.icons8.com/windows/452/person-male.png"),
                                  maxRadius: 50.0,
                                ),),
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        left: MediaQuery.of(context).size.width <= 360
                            ? MediaQuery.of(context).size.width - 90
                            : MediaQuery.of(context).size.width - 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // var selected =
                                  //     await DatePicker.showSimpleDatePicker(
                                  //   context,
                                  //   initialDate: datePicked,
                                  //   firstDate: DateTime.now(),
                                  //   dateFormat: "dd-MMMM-yyyy",
                                  //   locale: DateTimePickerLocale.en_us,
                                  //   looping: true,
                                  // );
                                  // selected != null
                                  //     ? setState(() {
                                  //         datePicked = selected;
                                  //       })
                                  //     : setState(() {
                                  //         datePicked = datePicked;
                                  //       });

                                  showDatePicker(
                                          context: context,
                                          initialDate: datePicked,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now()
                                              .add(Duration(days: 365)))
                                      .then((value) {
                                    if (value == null) {
                                      datePicked = datePicked;
                                    } else {
                                      setState(() {
                                        datePicked = value;
                                      });
                                    }
                                    counting(widget.database);
                                  });
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
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     if (widget.database != null) {
                            //       widget.database.updateData(
                            //           tokens.copyWith(shift: false), " ");
                            //       // generate(widget.database);
                            //     }
                            //   },
                            //   child: Container(
                            //       width: 35,
                            //       height: 35,
                            //       decoration: BoxDecoration(
                            //           color: white,
                            //           borderRadius: BorderRadius.circular(20)),
                            //       child: Icon(
                            //         Icons.watch_later,
                            //         color: pcolor,
                            //       )),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 7,
                        left: 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                '${DateFormat.yMMMd().format(datePicked).toString()}'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconBuilderAppointment(
                              "booked1.png",
                              countRows,
                              'Booked',
                            ),
                            IconBuilderAppointment(
                              "completed.png",
                              countComplete,
                              'Completed',
                            ),
                            IconBuilderAppointment(
                              "online-booking.png",
                              countOnline,
                              'Online',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconBuilderAppointment(
                              "fornt desk.png",
                              countonfront,
                              'Fornt Desk',
                            ),
                            IconBuilderAppointment(
                              "call-icon-png-15.png",
                              countoncall,
                              'On Call',
                            ),
                            IconBuilderAppointment(
                              "patient.png",
                              countPresent,
                              'Present',
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Available Tokens',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  IconButton(
                      icon: Icon(Icons.file_download),
                      onPressed: () async {
                        dynamic li = await widget.database
                            .getAllTasks(datePicked, _selecteddoc.id);
                        if (li.length == 0) {
                          generate(widget.database);
                        } else {
                          getTokens(
                              datePicked,
                              widget.database,
                              _selecteddoc.id.toString(),
                              widget.patientDatabase,
                              context);
                        }
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => widget.database.deleteallTask()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 80,
                    color: orangep,
                    child: _buildTaskList(
                        context,
                        datePicked,
                        counting,
                        widget.patientDatabase,
                        _selecteddoc == null ? 0 : _selecteddoc.id)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .9,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'search record',
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.search)),
                    onChanged: (val) {
                      setState(() {
                        query = val;
                      });
                    },
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      TokenTable(count: counting, query: query, date: datePicked),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

StreamBuilder<List<Token>> _buildTaskList(
    BuildContext context,
    DateTime datePicked,
    Function counting,
    PatientsDB patientDatabase,
    int clinicId) {
  final database = Provider.of<TokenDB>(context);
  return StreamBuilder(
    stream: database.watchondate(datePicked, clinicId),
    builder: (context, AsyncSnapshot<List<Token>> snapshot) {
      final tasks = snapshot.data ?? List();
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final itemTask = tasks[index];
          return SlotsWidget(
            itemTask: itemTask,
            database: database,
            count: counting,
            patientDatabase: patientDatabase,
          );
        },
      );
    },
  );
}
