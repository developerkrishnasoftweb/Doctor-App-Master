import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/pdf_config_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

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
  PdfConfig pdfConfig;
  PdfDocument document = PdfDocument();

  @override
  void initState() {
    super.initState();
    patientsVisitDB = Provider.of<PatientsVisitDB>(context, listen: false);
    getPatientData();
    generatePdf();
  }

  getPatientData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var configData = pref.getString('pdfConfig');
    if (configData != null) {
      setState(() {
        pdfConfig = PdfConfig.fromJson(jsonDecode(configData));
      });
    } else {
      PdfConfig config = await getPdfConfig();
      setState(() {
        pdfConfig = config;
      });
    }
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
        buildDetailRow("Appointment With", "Dr Anil Kumar Jain",
            pdfConfig.appointmentIdLable, pdfConfig.appointmentDateValue),
        buildDetailRow(
            "Appointment Date",
            "${patientsVisitData?.appointmentsTime?.toString()?.split(" ")?.first ?? ''}",
            pdfConfig.appointmentDateLable,
            pdfConfig.appointmentDateValue),
        buildDetailRow(
            "Visit Type",
            "${widget.token?.visittype?.toUpperCase() ?? ''}, Token No.- ${widget.token?.id ?? ''}",
            pdfConfig.visitTypeLabel,
            pdfConfig.visitTypeValue),
        pw.SizedBox(height: 10),
        buildDetailRow("Patient's Name:", "${widget.token?.name ?? ''}",
            pdfConfig.nameLable, pdfConfig.nameValue),
        buildDetailRow("Age:", "${widget.token?.age ?? ''} years",
            pdfConfig.ageLable, pdfConfig.ageValue),
        buildDetailRow("Gender:", "${widget.token?.gender ?? ''}",
            pdfConfig.genderLable, pdfConfig.genderValue),
        buildDetailRow("Address:", "${widget.token?.address ?? ''}",
            pdfConfig.addressLable, pdfConfig.addressValue),
        buildDetailRow("GUID:", "${widget.token?.guid ?? ''}",
            pdfConfig.ghidLable, pdfConfig.ghidValue),
        pw.Divider(),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("VITAL SIGNS", pdfConfig.vitalsLable),
                bulletItem("Temp: ${patientsVisitData?.temperature ?? ''}", pdfConfig.vitalsValue),
                bulletItem("Bp: ${patientsVisitData?.bp ?? ''} BPM", pdfConfig.vitalsValue),
                // bulletItem("Diastolic: ${patientsVisitData.} bpm"),
                bulletItem("Pulse: ${patientsVisitData?.pulse ?? ''} bpm", pdfConfig.vitalsValue),
                bulletItem("Weight: ${patientsVisitData?.weight ?? ''} KG", pdfConfig.vitalsValue),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("ALLERGIES", pdfConfig.allergiesLable),
                for (int i = 0;
                    i < (patientsVisitData?.allergies?.data?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.allergies.data[i].title}", pdfConfig.allergiesValue),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("LIFESTYLE", pdfConfig.lifestyleLable),
                for (int i = 0;
                    i < (patientsVisitData?.lifestyle?.data?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.lifestyle.data[i].title}", pdfConfig.lifestyleValue),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("EXAMINATION", pdfConfig.examinationLable),
                for (int i = 0;
                    i < (patientsVisitData?.examination?.data?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.examination.data[i].title}", pdfConfig.examinationValue),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("BRIEF HISTORY", pdfConfig.briefHistoryLable),
                for (int i = 0;
                    i < (patientsVisitData?.briefHistory?.data?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.briefHistory.data[i].title}", pdfConfig.briefHistoryValue),
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("DIAGNOSIS", pdfConfig.diagnosisLable),
                for (int i = 0;
                    i < (patientsVisitData?.diagnosis?.data?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.diagnosis.data[i].title}", pdfConfig.diagnosisValue),
              ]))
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("MEDICATION", pdfConfig.madicationLable),
                for (int i = 0;
                    i < (patientsVisitData?.medication?.data?.length ?? 0);
                    i++) ...[
                  // bulletItem("${patientsVisitData.medication.data[i].disease}"),
                  for (int j = 0;
                      j <
                          (patientsVisitData
                                  ?.medication?.data[i]?.medicines?.length ??
                              0);
                      j++)
                    bulletItem(
                        "${patientsVisitData.medication.data[i].medicines[j].title} (${patientsVisitData.medication.data[i].medicines[j].dose} ${patientsVisitData.medication.data[i].medicines[j].unit} ${patientsVisitData.medication.data[i].medicines[j].frequency} ${patientsVisitData.medication.data[i].medicines[j].duration})", pdfConfig.madicationValue)
                ],
              ])),
          pw.Expanded(
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                header("MEDICAL ADVICE", pdfConfig.adviceLable),
                for (int i = 0;
                    i < (patientsVisitData?.advices?.advices?.length ?? 0);
                    i++)
                  bulletItem("${patientsVisitData.advices.advices[i].advice}", pdfConfig.adviceValue),
                // bulletItem(
                //     "Make healthy eating and physical activity part of your daily routine."),
              ]))
        ]),
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          header("VISIT REASON", pdfConfig.visitReasonsLable),
          for (int i = 0;
              i < (patientsVisitData?.visitReason?.data?.length ?? 0);
              i++)
            bulletItem("${patientsVisitData.visitReason.data[i].title}", pdfConfig.visitReasonsValue),
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

  pw.Widget buildDetailRow(String title, String value,
      TextPdfConfig titleConfig, TextPdfConfig valueConfig) {
    return pw.Padding(
        child: pw.Row(children: [
          pw.Expanded(
              child: titleConfig.visibility
                  ? pw.Container(
                      child: pw.Text("$title",
                          style: titleConfig.textStyle ??
                              pw.TextStyle(
                                  color: titleConfig.color ??
                                      PdfColor.fromInt(0xff000000),
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold)),
                      margin: titleConfig.margin,
                      padding: titleConfig.padding)
                  : pw.SizedBox()),
          pw.Expanded(
              child: valueConfig.visibility
                  ? pw.Container(
                      margin: valueConfig.margin,
                      padding: valueConfig.padding,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text("$value",
                            style: valueConfig.textStyle ??
                                pw.TextStyle(
                                    color: valueConfig.color ??
                                        PdfColor.fromInt(0xff000000),
                                    fontSize: 18)),
                      ),
                    )
                  : pw.SizedBox()),
        ]),
        padding: pw.EdgeInsets.symmetric(vertical: 5));
  }

  pw.Widget header(String header, TextPdfConfig headConfig) {
    return headConfig.visibility
        ? pw.Align(
            child: pw.Container(
                child: pw.Text("$header".toUpperCase(),
                    style: headConfig.textStyle ??
                        pw.TextStyle(
                            color: headConfig.color ??
                                PdfColor.fromInt(0xff000000),
                            fontSize: 19,
                            fontWeight: pw.FontWeight.bold)),
                margin: headConfig.margin,
                padding: headConfig.padding ??
                    pw.EdgeInsets.symmetric(vertical: 10)),
            alignment: pw.Alignment.centerLeft)
        : pw.SizedBox();
  }

  pw.Widget bulletItem(String value, TextPdfConfig bulletItemConfig) {
    return bulletItemConfig.visibility ? pw.Container(
        margin: bulletItemConfig.margin,
        padding: bulletItemConfig.padding,
        child: pw.Text("\u2022 $value",
            style: bulletItemConfig.textStyle ??
                pw.TextStyle(
                    color:
                        bulletItemConfig.color ?? PdfColor.fromInt(0xff555555),
                    fontSize: 20),
            softWrap: true,
            maxLines: 3)) : pw.SizedBox();
  }

  void pageChanged(int page, int total) {
    setState(() {
      totalPage = total;
      currentPage = page + 1;
    });
  }
}
