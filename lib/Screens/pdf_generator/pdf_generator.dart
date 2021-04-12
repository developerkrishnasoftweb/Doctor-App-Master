import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PatientReport extends StatefulWidget {
  final String patientId;

  const PatientReport({Key key, this.patientId}) : super(key: key);

  @override
  _PatientReportState createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  PatientsVisitDB patientsVisitDB;
  PatientsVisitData patientsVisitData;
  pw.Document pdf = pw.Document();
  File generatedPDF;

  @override
  void initState() {
    super.initState();
    patientsVisitDB = Provider.of<PatientsVisitDB>(context, listen: false);
    getPatientData();
    generatePdf();
  }

  getPatientData() async {
    PatientsVisitData data =
        (await patientsVisitDB.getDiagnosis(widget.patientId)).first;
    setState(() {
      patientsVisitData = data;
    });
  }

  generatePdf() async {
    Directory directory = await getExternalStorageDirectory();
    // final im
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(
        children: [
          pw.Row(
            children: [
            ]
          )
        ]
      );
    }));
    final tempPDF = File('${directory.path + Platform.pathSeparator}report.pdf');
    tempPDF.writeAsBytes(await pdf.save());
    setState(() {
      generatedPDF = tempPDF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Patient Report", style: TextStyle(color: white)),
          backgroundColor: orange),
      body: generatedPDF != null ? PDFView(
        pdfData: generatedPDF.readAsBytesSync(),
        filePath: generatedPDF.path,
        defaultPage: 0,
        enableSwipe: true,
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
