import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Widgets/SlotBookingDialog.dart';

import 'package:intl/intl.dart';

class SlotsWidget extends StatelessWidget {
  final Token itemTask;
  final TokenDB database;
  final Function count;
  final Function colorChange;
  final PatientsDB patientDatabase;
  const SlotsWidget(
      {Key key,
      this.itemTask,
      this.database,
      this.count,
      this.colorChange,
      this.patientDatabase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => SlotBooking(
                time: itemTask.tokentime,
                tokenno: itemTask.tokenno,
                token: itemTask,
                count: count,
                changeColorAppointment: colorChange,
                database: database,
                patientDatabase: patientDatabase)),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: pcolor, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 3,
              ),
              Text(itemTask.tokenno.toString(),
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(DateFormat.jm().format(itemTask.tokentime).toString(),
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
    );
  }
}
