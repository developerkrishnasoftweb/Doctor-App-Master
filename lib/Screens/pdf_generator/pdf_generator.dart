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
    // final image = pw.MemoryImage(File('images/LOGO GETCURE.webp').readAsBytesSync());
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Padding(child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  // pw.Image(image),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text("AASTHA MULTI SPECIALIST HOSPITAL",
                            style: pw.TextStyle(
                                color: PdfColor.fromInt(0xff000000),
                                fontSize: 25,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text("Address: Delhi Sharanur Road Baraut",
                            style: pw.TextStyle(
                                color: PdfColor.fromInt(0xff000000),
                                fontSize: 23,
                                fontWeight: pw.FontWeight.bold)),
                      ])
                ]), padding: pw.EdgeInsets.symmetric(vertical: 10)),
            pw.Row(children: [
              pw.Expanded(
                  child: pw.Text("Appointment with: Dr Anil Kumar Jain",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("Appointment Date: 31 Jan 2021",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("New Visit, Token No.-5",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
            ]),
            pw.Row(children: [
              pw.Expanded(
                  child: pw.Text("Patient's Name: Mr Lal Singh",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("Age: 27 years",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("Gender: Male",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("Address: Mumbai",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
              pw.Expanded(
                  child: pw.Text("GHID: A9012345555",
                      style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff000000),
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold))),
            ])
          ]);
    }));
    final tempPDF =
        File('${directory.path + Platform.pathSeparator}report.pdf');
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
      body: generatedPDF != null
          ? PDFView(
              pdfData: generatedPDF.readAsBytesSync(),
              filePath: generatedPDF.path,
              defaultPage: 0,
              enableSwipe: true,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
