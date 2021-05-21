import 'package:flutter/material.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorInvoiceModel.dart';
import 'package:getcure_doctor/Widgets/dataTable.dart';
import 'package:getcure_doctor/Widgets/iconsloading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DoctorInvoice extends StatefulWidget {
  final String id;
  final String name;
  const DoctorInvoice({Key key, this.id,this.name}) : super(key: key);

  @override
  _DoctorInvoiceState createState() => _DoctorInvoiceState();
}

class _DoctorInvoiceState extends State<DoctorInvoice> {

  void initState(){
    super.initState();
    getcounts();
  }

  int countfee = 0;
  int countemerg = 0;
  int countnewVisit = 0;
  int followUp = 0;
  int oncall = 0;
  int totalAppointments = 0;
  var datePicked = DateTime.now();
  var datePickedend = DateTime.now().add(Duration(days: 1));
  DoctorInvoiceModel docmodel;
  void getcounts() async {
    countfee = 0;
    countemerg = 0;
    countnewVisit = 0;
    followUp = 0;
    totalAppointments = 0;
    docmodel = await getDocVoice(widget.id,datePicked.toString().substring(0,10), datePickedend.toString().substring(0,10));
    
    for (int i = 0; i < docmodel.data.length; i++) {
      countfee += docmodel.data[i].feesCollected;
    }
    for (int i = 0; i < docmodel.data.length; i++) {
      countemerg += docmodel.data[i].emergencies;
    }
    for (int i = 0; i < docmodel.data.length; i++) {
      countnewVisit += docmodel.data[i].newVisits;
    }
    for (int i = 0; i < docmodel.data.length; i++) {
      followUp += docmodel.data[i].followUps;
    }
    for (int i = 0; i < docmodel.data.length; i++) {
      oncall += docmodel.data[i].onCall;
    }
    for (int i = 0; i < docmodel.data.length; i++) {
      totalAppointments += docmodel.data[i].totalAppointments;
    }
    setState(() {
      countfee = countfee;
      countemerg = countemerg;
      countnewVisit = countnewVisit;
      followUp = followUp;
      oncall = oncall;
      totalAppointments = totalAppointments;
    });
  }

  _selectDateStart(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: datePicked,
      firstDate: DateTime.now().subtract(Duration(days:365 )),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != datePicked)
      setState(() {
        datePicked = picked;
      });
    String date = datePicked.toString();
    getcounts();
  }

  _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: datePickedend,
      firstDate: DateTime.now().subtract(Duration(days:365 )),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != datePickedend)
      setState(() {
        datePickedend = picked;
      });
    String date = datePickedend.toString();
    getcounts();
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
        // final dab = Provider.of<TokenDB>(context);
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
                      left: 77.0,
                      child: Container(
                        height: 35,
                        width: 180,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: orangep, width: 2.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: Center(
                            child: Text('Dr.' +widget.name,
                             style: TextStyle(color: black, fontSize: 18),
                            overflow: TextOverflow.ellipsis, ),
                            // child: DropdownButton<FrontDocData>(
                            //   value:
                            //       dropdownvalue == null ? null : dropdownvalue,
                            //   hint: Text('Select Doctor'),
                            //   iconSize: 24,
                            //   elevation: 16,
                            //   style: TextStyle(color: black),
                            //   underline: Container(
                            //     height: 0,
                            //     color: grey,
                            //   ),
                            //   onChanged: (FrontDocData newValue) {
                            //     setState(() {
                            //       dropdownvalue = newValue;
                            //     });

                            //     getcounts();
                            //   },
                            //   items: doc.map<DropdownMenuItem<FrontDocData>>(
                            //       (FrontDocData value) {
                            //     return DropdownMenuItem<FrontDocData>(
                            //       value: value,
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(left:8.0),
                            //         child: Text(
                            //            value.doctorName,
                            //            textAlign: TextAlign.center, 
                            //            style: TextStyle(fontSize:17.0 ), ),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
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
                            child: Icon(
                          Icons.account_circle,
                          size: 70,
                        )),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Todays Date : ${DateFormat.yMMMd().format(datePicked).toString()}'),
                ],
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
                            "dr fee.png",
                            countfee,
                            'Collected Fee',
                          ),
                          IconBuilderAppointment(
                            "new visit.png",
                            countnewVisit,
                            'New Visit',
                          ),
                          IconBuilderAppointment(
                            "follow up.png",
                            followUp,
                            'Follow Up ',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconBuilderAppointment(
                            "emergancy.png",
                            countemerg,
                            'Emergency',
                          ),
                          IconBuilderAppointment(
                            "by call.png",
                            oncall,
                            'By Call',
                          ),
                          IconBuilderAppointment(
                            "online-booking.png",
                            totalAppointments,
                            'Booked',
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
    
            Center(
              child: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                      text: 'Invoice for  from \t',
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
                              
                              _selectDateStart(context);
                              // getcounts();
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
                              .format(datePicked)
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
                            
                            _selectDateEnd(context);
                            // getcounts();
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
                              .format(datePickedend)
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DrInvoiceTable(
                  fetchinvoice: getDocVoice(widget.id,datePicked.toString().substring(0,10), datePickedend.toString().substring(0,10)),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

