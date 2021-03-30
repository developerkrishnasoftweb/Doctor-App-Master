import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/GetBigggerData.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorAppointmentHistoryModel.dart';
import 'package:getcure_doctor/Models/Appointments/DoctorInvoiceModel.dart';
import 'package:getcure_doctor/Widgets/AppointmentHistoryDetailDialog.dart';
import 'package:getcure_doctor/Widgets/updatebooking.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TokenTable extends StatefulWidget {
  final Function count;
  final String query;
  final DateTime date;
  const TokenTable({Key key, this.count, this.query, this.date})
      : super(key: key);
  @override
  _TokenTableState createState() => _TokenTableState();
}

class _TokenTableState extends State<TokenTable> {
  bool sort;
  @override
  void initState() {
    super.initState();
    sort = false;
  }

  List<Token> li = [];
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TokenDB>(context);
    return StreamBuilder(
        stream: database.watchAllTasks(widget.query, widget.date),
        builder: (context, AsyncSnapshot<List<Token>> list) {
          li = list.data;
          onSort(int columnIndex, bool ascending, List<Token> token) {
            if (columnIndex == 1) {
              if (ascending) {
                li.sort((a, b) => a.name.compareTo(b.name));
              } else {
                li.sort((a, b) => b.name.compareTo(a.name));
              }
            }
          }

          if (list.data != null) {
            return Container(
              height: 300,
              child: SingleChildScrollView(
                child: DataTable(
                    sortColumnIndex: 1,
                    sortAscending: sort,
                    columnSpacing: 8,
                    horizontalMargin: 5,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('T.no.'),
                      ),
                      DataColumn(
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            sort = !sort;
                          });
                          onSort(columnIndex, ascending, li);
                        },
                        label: Text('Patients Name'),
                      ),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('UGID')),
                      // DataColumn(label: Text('Date')),
                      // DataColumn(label: Text('Time')),
                      // DataColumn(label: Text('Visit')),
                      // DataColumn(label: Text('canceled'))
                    ],
                    rows: li
                        .map((p) => DataRow(cells: [
                              DataCell(Text(p.tokenno.toString()),
                                  onTap: () {}),
                              DataCell(
                                  Text(p.name,
                                      style: TextStyle(
                                          color: (p.isOnline)
                                              ? (green)
                                              : (p.cancelled == (true)
                                                  ? (grey)
                                                  : (p.appointmenttype ==
                                                          ('emergency')
                                                      ? (red)
                                                      : (p.bookedtype ==
                                                              ('on call')
                                                          ? orangef
                                                          : blueGrey))))),
                                  onTap: () => p.cancelled == false
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              UpdateBooking(
                                                id: p.id,
                                                time: p.tokentime,
                                                token: p,
                                                tokenno: p.tokenno,
                                                initialName: p.name,
                                                initialAge: p.age.toString(),
                                                initialAddress: p.address,
                                                initialMob:
                                                    p.mobileno.toString(),
                                                initialAppointmentType:
                                                    p.appointmenttype,
                                                initialBookigType: p.bookedtype,
                                                visitType: p.visittype,
                                                gender: p.gender,
                                                counter: widget.count,
                                                docId: p.doctorid,
                                              ))
                                      : {print('false')}),
                              DataCell(
                                  GetBiggerData(
                                      p.address,
                                      (p.isOnline)
                                          ? (green)
                                          : (p.cancelled == (true)
                                              ? (grey)
                                              : (p.appointmenttype ==
                                                      ('emergency')
                                                  ? (red)
                                                  : (p.bookedtype == ('on call')
                                                      ? orangef
                                                      : blueGrey)))),
                                  onTap: () {}),
                              DataCell(Text(
                                (p.visittype == "new visit"
                                        ? "   N "
                                        : "   F ") +
                                    (p.isPresent == true ? "   P " : "   A "),
                                style: TextStyle(
                                    color: (p.isOnline)
                                        ? (green)
                                        : (p.cancelled == (true)
                                            ? (grey)
                                            : (p.appointmenttype ==
                                                    ('emergency')
                                                ? (red)
                                                : (p.bookedtype == ('on call')
                                                    ? orangef
                                                    : blueGrey)))),
                              )),
                              DataCell(Text(
                                p.guid.toString(),
                                style: TextStyle(
                                    color: (p.isOnline)
                                        ? (green)
                                        : (p.cancelled == (true)
                                            ? (grey)
                                            : (p.appointmenttype ==
                                                    ('emergency')
                                                ? (red)
                                                : (p.bookedtype == ('on call')
                                                    ? orangef
                                                    : blueGrey)))),
                              )),
                              // DataCell(
                              //     Text(
                              //       DateFormat("dd-MM-yyyy")
                              //           .format(p.tokentime)
                              //           .toString(),
                              //       style: TextStyle(
                              //           color: (p.isOnline)
                              //               ? (green)
                              //               : (p.cancelled == (true)
                              //                   ? (grey)
                              //                   : (p.appointmenttype ==
                              //                           ('emergency')
                              //                       ? (red)
                              //                       : (p.bookedtype ==
                              //                               ('on call')
                              //                           ? orangef
                              //                           : blueGrey)))),
                              //     ),
                              //     onTap: () {}),
                              // DataCell(
                              //     Text(
                              //       DateFormat.jm()
                              //           .format(p.tokentime)
                              //           .toString(),
                              //       style: TextStyle(
                              //           color: (p.isOnline)
                              //               ? (green)
                              //               : (p.cancelled == (true)
                              //                   ? (grey)
                              //                   : (p.appointmenttype ==
                              //                           ('emergency')
                              //                       ? (red)
                              //                       : (p.bookedtype ==
                              //                               ('on call')
                              //                           ? orangef
                              //                           : blueGrey)))),
                              //     ),
                              //     onTap: () {}),
                              // DataCell(Text(
                              //   p.visittype,
                              //   style: TextStyle(
                              //       color: (p.cancelled == (true)
                              //           ? (grey)
                              //           : (p.appointmenttype == ('emergency')
                              //               ? (red)
                              //               : (p.bookedtype == ('on call')
                              //                   ? orangef
                              //                   : blueGrey)))),
                              // )),
                              // DataCell(
                              //   Text(
                              //     p.cancelled.toString(),
                              //     style: TextStyle(
                              //         color: (p.cancelled == (true)
                              //             ? (grey)
                              //             : (p.appointmenttype == ('emergency')
                              //                 ? (red)
                              //                 : (p.bookedtype == ('on call')
                              //                     ? orangef
                              //                     : blueGrey)))),
                              //   ),
                              // ),
                            ]))
                        .toList()),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class DrInvoiceTable extends StatefulWidget {
  final Future<DoctorInvoiceModel> fetchinvoice;
  const DrInvoiceTable({Key key, this.fetchinvoice}) : super(key: key);

  @override
  _DrInvoiceTableState createState() => _DrInvoiceTableState();
}

class _DrInvoiceTableState extends State<DrInvoiceTable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.fetchinvoice,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        } else {
          return Container(
            padding: EdgeInsets.only(bottom: 10.0),
            height: 300,
            child: SingleChildScrollView(
              child: DataTable(columnSpacing: 8, horizontalMargin: 5, columns: <
                  DataColumn>[
                DataColumn(
                  label: Text('Date'),
                ),
                DataColumn(label: Text('New Visit')),
                DataColumn(label: Text('Follow Up')),
                DataColumn(label: Text('Emergency')),
                DataColumn(label: Text('Total Appointment')),
                DataColumn(label: Text('Dr Fee')),
              ], rows: <DataRow>[
                for (int i = 0; i < snapshot.data.data.length; i++)
                  DataRow(
                    cells: [
                      DataCell(
                        Text(snapshot.data.data[i].date),
                      ),
                      DataCell(
                        Text(snapshot.data.data[i].newVisits.toString()),
                      ),
                      DataCell(
                        Text(snapshot.data.data[i].followUps.toString()),
                      ),
                      DataCell(
                        Text(snapshot.data.data[i].emergencies.toString()),
                      ),
                      DataCell(
                        Text(
                            snapshot.data.data[i].totalAppointments.toString()),
                      ),
                      DataCell(
                        Text(snapshot.data.data[i].feesCollected.toString()),
                      ),
                    ],
                  ),
              ]),
            ),
          );
        }
      },
    );
  }
}

class HopitalInvoiceTable extends StatefulWidget {
  //final Future<HospitalInvoiceModel>  fetchHospinvoice;
  //HopitalInvoiceTable({Key key,this.fetchHospinvoice}) : super(key: key);

  @override
  _HopitalInvoiceTableState createState() => _HopitalInvoiceTableState();
}

class _HopitalInvoiceTableState extends State<HopitalInvoiceTable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //  future: widget.fetchHospinvoice,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(columnSpacing: 8, horizontalMargin: 5, columns: <
                DataColumn>[
              DataColumn(label: Text("Doctor's Name")),
              DataColumn(label: Text('New Visit')),
              DataColumn(label: Text('Follow Up')),
              DataColumn(label: Text('Emgy')),
              DataColumn(label: Text('Total Appointment')),
              DataColumn(label: Text('Coolected Dr. Fee')),
            ], rows: <DataRow>[
              for (int i = 0; i < snapshot.data.data.length; i++)
                DataRow(
                  cells: [
                    DataCell(
                      Text('Dr. ' + snapshot.data.data[i].doctorName),
                    ),
                    DataCell(
                      Text(snapshot.data.data[i].newVisits.toString()),
                    ),
                    DataCell(
                      Text(snapshot.data.data[i].followUps.toString()),
                    ),
                    DataCell(
                      Text(snapshot.data.data[i].emergencies.toString()),
                    ),
                    DataCell(
                      Text(snapshot.data.data[i].totalAppointments.toString()),
                    ),
                    DataCell(
                      Text(snapshot.data.data[i].feesCollected.toString()),
                    ),
                  ],
                ),
            ]),
          );
        }
      },
    );
  }
}

class AppointmentHistoryTable extends StatefulWidget {
  // final Future<AppointmentHistoryFetch> fetchdata;
  final String startDate;
  final String endDate;
  final int docId;
  final String query;
  AppointmentHistoryTable(
      {Key key, this.startDate, this.endDate, this.docId, this.query})
      : super(key: key);
  @override
  _AppointmentHistoryTableState createState() =>
      _AppointmentHistoryTableState();
}

class _AppointmentHistoryTableState extends State<AppointmentHistoryTable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: widget.fetchdata,
      future: appointmenthistoryfetch(
          widget.startDate, widget.endDate, widget.docId, widget.query),
      builder: (BuildContext context,
          AsyncSnapshot<DoctorAppointmentHistoryModel> snapshot) {
        if (snapshot.data == null) {
          print("No data");
          return CircularProgressIndicator();
        } else {
          return Container(
            // width: MediaQuery.of(context).size.width,

            child: DataTable(columns: <DataColumn>[
              DataColumn(label: Text("Sno."), numeric: true),
              DataColumn(label: Text("UGID")),
              DataColumn(label: Text('Patient Name')),
              DataColumn(label: Center(child: Text('Address'))),
              DataColumn(label: Text('Date')),
            ], rows: <DataRow>[
              for (int i = 0; i < snapshot.data.data.length; i++)
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        (i + 1).toString(),
                      ),
                    ),
                    DataCell(
                        Text(
                          snapshot.data.data[i].patientId,
                          style: TextStyle(
                              color: (snapshot.data.data[i].bookingType ==
                                      "cancelled")
                                  ? (grey)
                                  : (snapshot.data.data[i].appointmentType ==
                                          ('emergency')
                                      ? (red)
                                      : (snapshot.data.data[i].bookingType ==
                                              ('on call')
                                          ? orangef
                                          : blueGrey))),
                        ), onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AppointmentHistoryDetails(historyData:snapshot.data.data[i] ,)
                      );
                    }),
                    // DataCell(
                    //   Center(
                    //       child: Text(
                    //     snapshot.data.data[i].tokenNo.toString(),
                    //     style: TextStyle(
                    //         color: (snapshot.data.data[i].bookingType ==
                    //                 "cancelled")
                    //             ? (grey)
                    //             : (snapshot.data.data[i].appointmentType ==
                    //                     ('emergency')
                    //                 ? (red)
                    //                 : (snapshot.data.data[i].bookingType ==
                    //                         ('on call')
                    //                     ? orangef
                    //                     : blueGrey))),
                    //   )),
                    // ),
                    DataCell(
                      Text(
                        snapshot.data.data[i].patientName,
                        style: TextStyle(
                            color: (snapshot.data.data[i].bookingType ==
                                    "cancelled")
                                ? (grey)
                                : (snapshot.data.data[i].appointmentType ==
                                        ('emergency')
                                    ? (red)
                                    : (snapshot.data.data[i].bookingType ==
                                            ('on call')
                                        ? orangef
                                        : blueGrey))),
                      ),
                    ),
                    DataCell(
                      Center(
                          child: Text(
                            snapshot.data.data[i].patient.address,
                        style: TextStyle(
                            color: (snapshot.data.data[i].bookingType ==
                                    "cancelled")
                                ? (grey)
                                : (snapshot.data.data[i].appointmentType ==
                                        ('emergency')
                                    ? (red)
                                    : (snapshot.data.data[i].bookingType ==
                                            ('on call')
                                        ? orangef
                                        : blueGrey))),
                      )),
                    ),
                    DataCell(
                      Center(
                          child: Text(
                        DateFormat('dd-MM-yyyy')
                            .format((DateTime.parse(
                                snapshot.data.data[i].appointmentTime)))
                            .toString(),
                        style: TextStyle(
                            color: (snapshot.data.data[i].bookingType ==
                                    "cancelled")
                                ? (grey)
                                : (snapshot.data.data[i].appointmentType ==
                                        ('emergency')
                                    ? (red)
                                    : (snapshot.data.data[i].bookingType ==
                                            ('on call')
                                        ? orangef
                                        : blueGrey))),
                      )),
                    ),
                    // DataCell(
                    //   Center(
                    //     child: Text(
                    //       snapshot.data.data[i].date,
                    //       style: TextStyle(
                    //           color: (snapshot.data.data[i].bookingType ==
                    //                   "cancelled")
                    //               ? (grey)
                    //               : (snapshot.data.data[i]
                    //                           .appointmentType ==
                    //                       ('emergency')
                    //                   ? (red)
                    //                   : (snapshot.data.data[i]
                    //                               .bookingType ==
                    //                           ('on call')
                    //                       ? orangef
                    //                       : blueGrey))),
                    //     ),
                    //   ),
                    // ),
                    // DataCell(
                    //   Center(child: Text(snapshot.data.data[i].feesCollected.toString())),
                    // ),
                  ],
                ),
            ]),
          );
        }
      },
    );
  }
}
