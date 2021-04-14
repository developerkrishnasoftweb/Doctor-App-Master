import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PatientReport extends StatefulWidget {
  final String patientId;
  final Token token;

  const PatientReport({Key key, this.patientId, this.token}) : super(key: key);

  @override
  _PatientReportState createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  PatientsVisitDB patientsVisitDB;
  PatientsVisitData patientsVisitData;
  pw.Document pdf;
  File generatedPDF;
  int currentPage = 0, totalPage = 0;

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
    pw.ThemeData myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}OpenSans-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}OpenSans-Bold.ttf")),
      italic: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}OpenSans-Italic.ttf")),
      boldItalic: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}OpenSans-BoldItalic.ttf")),
    );
    pdf = pw.Document(theme: myTheme);
    final image = pw.MemoryImage(
        (await rootBundle.load('images/getcure logo.png'))
            .buffer
            .asUint8List());
    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.SizedBox(width: double.infinity),
        pw.Padding(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(image, height: 60, width: 60),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                        pw.Text("AASTHA MULTI SPECIALIST HOSPITAL",
                            style: pw.TextStyle(
                                color: PdfColor.fromInt(0xff000000),
                                fontSize: 23,
                                fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.center),
                        pw.Text("Address: Delhi Sharanur Road Baraut",
                            style: pw.TextStyle(
                                color: PdfColor.fromInt(0xff000000),
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold)),
                      ]))
                ]),
            padding: pw.EdgeInsets.symmetric(vertical: 10)),
        pw.Divider(),
        header("APPOINTMENT DETAILS"),
        buildDetailRow("Appointment With", "Dr Anil Kumar Jain"),
        buildDetailRow("Appointment Date",
            "${patientsVisitData.appointmentsTime.toString().split(" ").first}"),
        buildDetailRow("Visit Type",
            "${widget.token.visittype.toUpperCase()}, Token No.- ${widget.token.id}"),
        pw.SizedBox(height: 10),
        header("PATIENT DETAILS"),
        buildDetailRow("Patient's Name:", "${widget.token.name}"),
        buildDetailRow("Age:", "${widget.token.age} years"),
        buildDetailRow("Gender:", "${widget.token.gender}"),
        buildDetailRow("Address:", "${widget.token.address}"),
        buildDetailRow("GUID:", "${widget.token.guid}"),
        pw.Divider(),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("VITAL SIGNS"),
                bulletItem("Temp: ${patientsVisitData.temperature}"),
                bulletItem("Bp: ${patientsVisitData.bp} BPM"),
                // bulletItem("Diastolic: ${patientsVisitData.} bpm"),
                bulletItem("Pulse: ${patientsVisitData.pulse} bpm"),
                bulletItem("Weight: ${patientsVisitData.weight} KG"),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("ALLERGIES"),
                for (int i = 0;
                    i < patientsVisitData.allergies.data.length;
                    i++)
                  bulletItem("${patientsVisitData.allergies.data[i].title}"),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("LIFESTYLE"),
                for (int i = 0;
                    i < patientsVisitData.lifestyle.data.length;
                    i++)
                  bulletItem("${patientsVisitData.lifestyle.data[i].title}"),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("EXAMINATION"),
                for (int i = 0;
                    i < patientsVisitData.examination.data.length;
                    i++)
                  bulletItem("${patientsVisitData.examination.data[i].title}"),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("BRIEF HISTORY"),
                for (int i = 0;
                    i < patientsVisitData.briefHistory.data.length;
                    i++)
                  bulletItem("${patientsVisitData.briefHistory.data[i].title}"),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("DIAGNOSIS"),
                for (int i = 0;
                    i < patientsVisitData.diagnosis.data.length;
                    i++)
                  bulletItem("${patientsVisitData.diagnosis.data[i].title}"),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("MEDICATION"),
                for (int i = 0;
                    i < patientsVisitData.medication.data.length;
                    i++) ...[
                  // bulletItem("${patientsVisitData.medication.data[i].disease}"),
                  for (int j = 0;
                      j < patientsVisitData.medication.data[i].medicines.length;
                      j++)
                    bulletItem(
                        "${patientsVisitData.medication.data[i].medicines[j].title} (${patientsVisitData.medication.data[i].medicines[j].dose} ${patientsVisitData.medication.data[i].medicines[j].unit} ${patientsVisitData.medication.data[i].medicines[j].frequency} ${patientsVisitData.medication.data[i].medicines[j].duration})")
                ],
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("MEDICAL ADVICE"),
                for (int i = 0;
                    i < patientsVisitData.advices.advices.length;
                    i++)
                  bulletItem("${patientsVisitData.advices.advices[i].advice}"),
                // bulletItem(
                //     "Make healthy eating and physical activity part of your daily routine."),
              ]))
        ]),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          header("VISIT REASON"),
          for (int i = 0; i < patientsVisitData.visitReason.data.length; i++)
            bulletItem("${patientsVisitData.visitReason.data[i].title}"),
          // bulletItem("Muscle Aches (6 Days)"),
          // bulletItem("High Fever (6 Days)"),
        ])
      ];
    }));
    final tempPDF =
        File('${directory.path + Platform.pathSeparator}report.pdf');
    await tempPDF.writeAsBytes(await pdf.save());
    setState(() {
      generatedPDF = tempPDF;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Patient Report", style: TextStyle(color: white)),
          backgroundColor: orange,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("$currentPage / $totalPage"),
              ),
            )
          ]),
      body: generatedPDF != null
          ? PDFView(
              pdfData: generatedPDF.readAsBytesSync(),
              defaultPage: 0,
              enableSwipe: true,
              onPageChanged: pageChanged,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  pw.Widget buildDetailRow(String title, String value) {
    return pw.Padding(
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Text("$title",
                  style: pw.TextStyle(
                      color: PdfColor.fromInt(0xff000000),
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold))),
          pw.Expanded(
              child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text("$value",
                style: pw.TextStyle(
                    color: PdfColor.fromInt(0xff000000), fontSize: 18)),
          )),
        ]),
        padding: pw.EdgeInsets.symmetric(vertical: 5));
  }

  pw.Widget header(String header) {
    return pw.Align(
        child: pw.Padding(
            child: pw.Text("$header".toUpperCase(),
                style: pw.TextStyle(
                    color: PdfColor.fromInt(0xff000000),
                    fontSize: 19,
                    fontWeight: pw.FontWeight.bold)),
            padding: pw.EdgeInsets.symmetric(vertical: 10)),
        alignment: pw.Alignment.centerLeft);
  }

  pw.Widget bulletItem(String value) {
    return pw.Text("\u2022 $value",
        style: pw.TextStyle(color: PdfColor.fromInt(0xff555555), fontSize: 20),
        softWrap: true,
        maxLines: 3);
  }

  void pageChanged(int page, int total) {
    setState(() {
      totalPage = total;
      currentPage = page + 1;
    });
  }
}
