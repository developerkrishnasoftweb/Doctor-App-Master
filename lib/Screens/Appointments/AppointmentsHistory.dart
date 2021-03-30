import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorAppointmentHistoryModel.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Widgets/dataTable.dart';
import 'package:getcure_doctor/Widgets/iconsloading.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentHistory extends StatefulWidget {
  final List<ClinicDoctor> clinicDoctor;
  final DoctorLoginData docUser;
  const DoctorAppointmentHistory({Key key, this.clinicDoctor,this.docUser}) : super(key: key);
  @override
  _DoctorAppointmentHistoryState createState() => _DoctorAppointmentHistoryState();
}

class _DoctorAppointmentHistoryState extends State<DoctorAppointmentHistory> {
  List<ClinicDoctor> doc = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      doc = widget.clinicDoctor;
      dropdownvalue = doc[0];
      selectedDate = DateTime.now();
      selectedDateEnd = DateTime.now().add(Duration(days: 1));
    });
    countvalues();
  }

  String query = "";
  ClinicDoctor dropdownvalue;
  DateTime selectedDate ;
  DateTime selectedDateEnd ;
  
  _selectDateStart(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days:365 )),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        countvalues();  
      });
    String date = selectedDate.toString();
    print("date= " + date);
  }

  _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateEnd,
      firstDate: DateTime.now().subtract(Duration(days:365 )),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDateEnd)
      setState(() {
        selectedDateEnd = picked;
        countvalues();  
      });
    String date = selectedDateEnd.toString();
    print("date= " + date);
  }
  int countTotal = 0;
  int countCancelled = 0;
  int countCompleted = 0;
  int upcomingCount=0;
  void countvalues() async {
    countTotal = 0;
    countCancelled = 0;
    countCompleted = 0;
    upcomingCount=0;
    DoctorAppointmentHistoryModel daily = await appointmenthistoryfetch(
        selectedDate.toString().substring(0, 11),
        selectedDateEnd.toString().substring(0, 11),
        dropdownvalue.id,
        query);
    for (int i = 0; i < daily.data.length; i++) {
      if (daily.data[i].bookingType == "cancelled") {
        countCancelled++;
      }

      if (daily.data[i].bookingType == "completed") {
        countCompleted++;
      }
    }
    countTotal = daily.data.length;
    setState(() {
      countTotal = countTotal;
      countCancelled = countCancelled;
      countCompleted = countCompleted;
      upcomingCount = daily.data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        backgroundColor: orangef,
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
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
                        width: 200,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: orangep, width: 2.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 0),
                          child: FittedBox(
                            fit:BoxFit.fitWidth,
                              child: Center(
                              child: DropdownButton<ClinicDoctor>(
                                value:
                                    dropdownvalue == null ? null : dropdownvalue,
                                hint: Text('Select Doctor'),
                                elevation: 16,
                                onChanged: (ClinicDoctor newValue) {
                                  setState(() {
                                    dropdownvalue = newValue;
                                  });
                                  countvalues();
                                },
                                items: doc.map<DropdownMenuItem<ClinicDoctor>>(
                                    (ClinicDoctor value) {
                                  return DropdownMenuItem<ClinicDoctor>(
                                    value: value,
                                    child: value != null
                                        ? Text(
                                            value.clinic.name,
                                          )
                                        : Text(''),
                                  );
                                }).toList(),
                              ),
                            ),
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
                                backgroundImage: widget
                                            .docUser.imageUrl !=
                                        null
                                    ? NetworkImage(
                                        widget.docUser.imageUrl)
                                    : NetworkImage(
                                        "https://img.icons8.com/windows/452/person-male.png"),
                                maxRadius: 50.0,
                              ),
                            ),
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
                              '${DateFormat.yMMMd().format(selectedDate).toString()}'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                      text: 'Appointments History from  \t',
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        // fontWeight: FontWeight.bold
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: GestureDetector(
                            onTap: () async {
                              // var selected =
                              //     await DatePicker.showSimpleDatePicker(
                              //   context,
                              //   initialDate: selectedDate,
                              //   firstDate: DateTime.now().add(Duration(
                              //     days: -360,
                              //   )),
                              //   dateFormat: "dd-MMMM-yyyy",
                              //   locale: DateTimePickerLocale.en_us,
                              //   looping: true,
                              // );
                              // selected != null
                              //     ? setState(() {
                              //         selectedDate = selected;
                              //         // getcounts();
                              //       })
                              //     : setState(() {
                              //         selectedDate = selectedDate;
                              //       });
                              // countvalues();
                              _selectDateStart(context);
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
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(selectedDate)
                              .toString(),
                          style: TextStyle(
                            color: orangef,
                            fontSize: 15,
                            // fontWeight: FontWeight.w300
                          ),
                        ),
                        Text(' to '),
                        GestureDetector(
                          onTap: () async {
                            // var selectedend =
                            //     await DatePicker.showSimpleDatePicker(
                            //   context,
                            //   initialDate: selectedDateEnd,
                            //   firstDate: DateTime.now().add(Duration(
                            //     days: -360,
                            //   )),
                            //   dateFormat: "dd-MMMM-yyyy",
                            //   locale: DateTimePickerLocale.en_us,
                            //   looping: true,
                            // );
                            // selectedend != null
                            //     ? setState(() {
                            //         selectedDateEnd = selectedend;
                            //         // getcounts();
                            //       })
                            //     : setState(() {
                            //         selectedDateEnd = selectedDateEnd;
                            //       });
                            // countvalues();
                            _selectDateEnd(context);
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
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(selectedDateEnd)
                              .toString(),
                          style: TextStyle(
                            color: orangef,
                            fontSize: 15,
                            // fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconBuilderAppointment(
                            "appointment-scheduling.png",
                            countTotal,
                            'Total Appointment',
                          ),
                          IconBuilderAppointment(
                            "cancel appointment.png",
                            countCancelled,
                            'Cancel Appointment',
                          ),
                          
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconBuilderAppointment(
                            "completed.png",
                            countCompleted,
                            'Complete',
                          ),
                          IconBuilderAppointment(
                            "upcoming.png",
                            upcomingCount,
                            'Upcoming',
                          ),
                        ],
                      ),
                    ],
                  )),
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
            SizedBox(
              height: 50.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentHistoryTable(
                  startDate: selectedDate.toString().substring(0, 11),
                  endDate: selectedDateEnd.toString().substring(0, 11),
                  docId: dropdownvalue.id,
                  query: query,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}