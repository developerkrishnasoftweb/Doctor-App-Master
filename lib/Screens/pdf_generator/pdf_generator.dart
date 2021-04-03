import 'package:flutter/material.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:provider/provider.dart';

class PatientReport extends StatefulWidget {
  final String patientId;

  const PatientReport({Key key, this.patientId}) : super(key: key);
  @override
  _PatientReportState createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  PatientsVisitDB patientsVisitDB;
  PatientsVisitData patientsVisitData;
  @override
  void initState() {
    super.initState();
    patientsVisitDB = Provider.of<PatientsVisitDB>(context, listen: false);
    getPatientData();
  }
  getPatientData() async {
    PatientsVisitData data = (await patientsVisitDB.getDiagnosis(widget.patientId)).first;
    setState(() {
      patientsVisitData = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Report", style: TextStyle(color: black))),
      body: Column(
        children: [
          Text(patientsVisitData?.patientName ?? "N/A"),
        ]
      ),
    );
  }
}
