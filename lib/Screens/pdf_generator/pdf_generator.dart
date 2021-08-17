import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getcure_doctor/Database/PatientsVisitTable.dart';
import 'package:getcure_doctor/Database/TokenTable.dart';
import 'package:getcure_doctor/Helpers/AppConfig/colors.dart';
import 'package:getcure_doctor/Helpers/Network/DataSyncFunctions.dart';
import 'package:getcure_doctor/Helpers/Network/Requesthttp.dart';
import 'package:getcure_doctor/Models/DoctorLogin.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';
import 'package:getcure_doctor/Models/pdf_config_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sync;

class PatientReport extends StatefulWidget {
  final String patientId;
  final Token token;
  final List<AdviceData> advices;

  const PatientReport(
      {Key key, this.patientId, this.token, this.advices = const []})
      : super(key: key);

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
  PdfPageFormat selectedPageFormat = PdfPageFormat.a3;
  List<PdfPageFormat> pdfPageFormats = <PdfPageFormat>[
    PdfPageFormat.a3,
    PdfPageFormat.a4,
    PdfPageFormat.a5,
    PdfPageFormat.legal,
    PdfPageFormat.letter
  ];

  @override
  void initState() {
    super.initState();
    patientsVisitDB = Provider.of<PatientsVisitDB>(context, listen: false);
    getPatientData();
  }

  getPatientData() async {
    PdfConfig config = await getPdfConfig();
    setState(() {
      pdfConfig = config;
    });
    PatientsVisitData data =
        (await patientsVisitDB.checkPatient(widget.patientId)).last;
    setState(() {
      patientsVisitData = data;
    });
    generatePdf();
  }

  generatePdf() async {
    Directory directory = await getExternalStorageDirectory();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String doctors = pref.getString('docDataResponse');
    final docUser = DoctorLoginData.fromJson(json.decode(doctors));
    pw.ThemeData myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}NotoSans-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}NotoSans-Bold.ttf")),
      italic: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}NotoSans-Italic.ttf")),
      boldItalic: pw.Font.ttf(await rootBundle
          .load("fonts${Platform.pathSeparator}NotoSans-BoldItalic.ttf")),
    );
    pdf = pw.Document(theme: myTheme);

    pdf.addPage(pw.MultiPage(
        // theme: pw.ThemeData(
        //   softWrap: true
        // ),
        pageTheme: pw.PageTheme(pageFormat: selectedPageFormat),
        build: (context) {
          return [
            pw.SizedBox(width: double.infinity),
            pw.Padding(
                child: pw.Align(
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
                        ]),
                    alignment: pw.Alignment.center),
                padding: pw.EdgeInsets.symmetric(vertical: 10)),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Expanded(
                    child: buildDetailRow(
                        "Appointment With",
                        "${docUser.name}",
                        pdfConfig?.appointmentIdLable,
                        pdfConfig?.appointmentDateValue),
                  ),
                  pw.Expanded(
                    child: buildDetailRow(
                        "Appointment Date",
                        "${patientsVisitData?.appointmentsTime?.toString()?.split(" ")?.first ?? ''}",
                        pdfConfig?.appointmentDateLable,
                        pdfConfig?.appointmentDateValue),
                  ),
                  pw.Expanded(
                    child: buildDetailRow(
                        "Visit Type",
                        "${widget.token?.visittype?.toUpperCase() ?? ''}, Token No.- ${widget.token?.id ?? ''}",
                        pdfConfig?.visitTypeLabel,
                        pdfConfig?.visitTypeValue),
                  )
                ]),
            pw.SizedBox(height: 50),
            pw.Row(children: [
              pw.Expanded(
                child: buildDetailRow(
                    "Patient's Name:",
                    "${widget.token?.name ?? ''}",
                    pdfConfig?.nameLable,
                    pdfConfig?.nameValue),
              ),
              pw.Expanded(
                child: buildDetailRow(
                    "Age:",
                    "${widget.token?.age ?? ''} years",
                    pdfConfig?.ageLable,
                    pdfConfig?.ageValue),
              ),
              pw.Expanded(
                child: buildDetailRow(
                    "Gender:",
                    "${widget.token?.gender ?? ''}",
                    pdfConfig?.genderLable,
                    pdfConfig?.genderValue),
              ),
              pw.Expanded(
                child: buildDetailRow(
                    "Address:",
                    "${widget.token?.address ?? ''}",
                    pdfConfig?.addressLable,
                    pdfConfig?.addressValue),
              )
              // buildDetailRow("GUID:", "${widget.token?.guid ?? ''}",
              //     pdfConfig?.ghidLable, pdfConfig?.ghidValue),
            ]),
            pw.SizedBox(height: 50),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // 1/3 part of screen
                  pw.Expanded(
                      flex: 1,
                      child: pw.Column(children: [
                        //Vital Signs section
                        header("VITAL SIGNS", pdfConfig?.vitalsLable),
                        bulletItem(
                            "Temp: ${patientsVisitData?.temperature ?? ''}",
                            pdfConfig?.vitalsValue),
                        bulletItem("Bp: ${patientsVisitData?.bp ?? ''} BPM",
                            pdfConfig?.vitalsValue),
                        // bulletItem("Diastolic: ${patientsVisitData.} bpm"),
                        bulletItem(
                            "Pulse: ${patientsVisitData?.pulse ?? ''} bpm",
                            pdfConfig?.vitalsValue),
                        bulletItem(
                            "Weight: ${patientsVisitData?.weight ?? ''} KG",
                            pdfConfig?.vitalsValue),

                        //Lifestyle section
                        header("LIFESTYLE", pdfConfig?.lifestyleLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.lifestyle?.data?.length ??
                                    0);
                            i++)
                          bulletItem(
                              "${patientsVisitData.lifestyle.data[i].title}",
                              pdfConfig?.lifestyleValue),

                        // Examination section
                        header("EXAMINATION", pdfConfig?.examinationLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.examination?.data?.length ??
                                    0);
                            i++) ...[
                          bulletItem(
                              "${patientsVisitData.examination.data[i].title}",
                              pdfConfig?.examinationKey,
                              showBullets: false),
                          for (int j = 0;
                              j <
                                  patientsVisitData
                                      .examination.data[i].parameters.length;
                              j++)
                            bulletItem(
                                '${patientsVisitData.examination.data[i].parameters[j].title} ${patientsVisitData.examination.data[i].parameters[j].bioReference != null && patientsVisitData.examination.data[i].parameters[j].bioReference.isNotEmpty ? patientsVisitData.examination.data[i].parameters[j].bioReference[0] : ''}',
                                pdfConfig?.examinationValue)
                        ],

                        // Allergies section
                        header("ALLERGIES", pdfConfig?.allergiesLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.allergies?.data?.length ??
                                    0);
                            i++)
                          bulletItem(
                              "${patientsVisitData.allergies.data[i].title}",
                              pdfConfig?.allergiesValue),
                      ])),

                  pw.SizedBox(width: 10),
                  // 2/3 part of screen
                  pw.Expanded(
                      flex: 2,
                      child: pw.Column(children: [
                        // Visit reason section
                        header("VISIT REASON", pdfConfig?.visitReasonsLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.visitReason?.data?.length ??
                                    0);
                            i++)
                          bulletItem(
                              "${patientsVisitData.visitReason.data[i].title}",
                              pdfConfig?.visitReasonsValue),

                        //Brief history section
                        header("BRIEF HISTORY", pdfConfig?.briefHistoryLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData
                                        ?.briefHistory?.data?.length ??
                                    0);
                            i++)
                          bulletItem(
                              "${patientsVisitData.briefHistory.data[i].title}",
                              pdfConfig?.briefHistoryValue),
                        // Diagnosis Section
                        header("DIAGNOSIS", pdfConfig?.diagnosisLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.diagnosis?.data?.length ??
                                    0);
                            i++)
                          bulletItem(
                              "${patientsVisitData.diagnosis.data[i].title}",
                              pdfConfig?.diagnosisValue),

                        // Medication Section
                        header("MEDICATION", pdfConfig?.madicationLable),
                        for (int i = 0;
                            i <
                                (patientsVisitData?.medication?.data?.length ??
                                    0);
                            i++) ...[
                          for (int j = 0;
                              j <
                                  (patientsVisitData?.medication?.data[i]
                                          ?.medicines?.length ??
                                      0);
                              j++) ...[
                            bulletItem(
                                "${patientsVisitData.medication.data[i].medicines[j].title} (${patientsVisitData.medication.data[i].medicines[j].dose} ${patientsVisitData.medication.data[i].medicines[j].unit} ${patientsVisitData.medication.data[i].medicines[j].frequency} ${patientsVisitData.medication.data[i].medicines[j].duration})",
                                pdfConfig?.madicationValue)
                          ]
                        ],

                        // Medial Advice
                        header("MEDICAL ADVICE", pdfConfig?.adviceLable),
                        for (int i = 0; i < widget.advices.length; i++)
                          bulletItem("${widget.advices[i].advice}",
                              pdfConfig?.adviceValue),
                      ])),
                ]),
          ];
        }));
    final tempPDF =
        File('${directory.path + Platform.pathSeparator}report.pdf');
    await tempPDF.writeAsBytes(await _addWatermarkToPDF(await pdf.save()));
    setState(() {
      generatedPDF = tempPDF;
    });
  }

  Future<List<int>> _addWatermarkToPDF(Uint8List file) async {
    // Load url
    File backgroundImage = await downloadImageToLocal('${pdfConfig.imageURL}',
        downloadProgress: (received, total) {
      print("$received of $total");
    });

    //Load the document
    ByteData data = file.buffer.asByteData();
    sync.PdfDocument document = sync.PdfDocument(
        inputBytes:
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    //Get first page from document
    sync.PdfPage page = document.pages[0];
    //Create PDF graphics for the page
    sync.PdfGraphics graphics = page.graphics;
    //Save the graphics state for the watermark text
    graphics.save();
    //Set transparency level for the text
    graphics.setTransparency(0.4);
    //Rotate the text to -40 Degree
    // graphics.rotateTransform(-40);
    //Draw the watermark text to the desired position over the PDF page with red color
    // final rootImage = await rootBundle.load('images/getcure logo.png');
    ByteData byteData = backgroundImage.readAsBytesSync().buffer.asByteData();
    graphics.drawImage(
        sync.PdfBitmap(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
        Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));
    //Restore the graphics
    graphics.restore();
    //Save the docuemnt
    List<int> bytes = document.save();
    document.dispose();
    //Dispose the document.
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    // print(patientsVisitData.examination.data[1].parameters[0].references);
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.print),
              onPressed: () async {
                await Printing.layoutPdf(
                    onLayout: (context) => generatedPDF.readAsBytesSync());
              }),
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.shareFiles([generatedPDF.path],
                    text: '${widget.token?.name ?? ''} REPORT'.toUpperCase());
              }),
          DropdownButton<PdfPageFormat>(
            items: pdfPageFormats.map((format) {
              return DropdownMenuItem(
                  child: Text(pageFormat(format)), value: format);
            }).toList(),
            value: selectedPageFormat,
            onChanged: (format) {
              setState(() {
                selectedPageFormat = format;
                generatedPDF = null;
              });
              generatePdf();
            },
          ),
        ],
      ),
    );
  }

  pw.Widget buildDetailRow(String title, String value,
      TextPdfConfig titleConfig, TextPdfConfig valueConfig) {
    if (titleConfig == null) {
      titleConfig = TextPdfConfig();
    }
    if (valueConfig == null) {
      valueConfig = TextPdfConfig();
    }
    return pw.RichText(
        text: pw.TextSpan(children: [
      pw.WidgetSpan(
        child: titleConfig.visibility
            ? pw.Container(
                margin: titleConfig.margin,
                padding: titleConfig.padding,
                child: pw.Text("$title",
                    style: pw.TextStyle(
                        color:
                            titleConfig.color ?? PdfColor.fromInt(0xff000000),
                        fontSize: titleConfig.fontSize,
                        fontWeight: pw.FontWeight.bold)))
            : pw.SizedBox(),
      ),
      pw.WidgetSpan(child: pw.SizedBox(height: 10)),
      pw.WidgetSpan(
        child: valueConfig.visibility
            ? pw.Container(
                margin: valueConfig.margin,
                padding: valueConfig.padding,
                child: pw.Text("$value",
                    style: pw.TextStyle(
                        color:
                            valueConfig.color ?? PdfColor.fromInt(0xff000000),
                        fontSize: valueConfig.fontSize,
                        fontWeight: pw.FontWeight.bold)))
            : pw.SizedBox(),
      )
    ]));
  }

  pw.Widget header(String header, TextPdfConfig headConfig) {
    if (headConfig == null) {
      headConfig = TextPdfConfig();
    }
    return headConfig.visibility
        ? pw.Align(
            child: pw.Container(
                child: pw.Text("$header".toUpperCase(),
                    style: pw.TextStyle(
                        color: headConfig.color ?? PdfColor.fromInt(0xff000000),
                        fontSize: headConfig.fontSize,
                        fontWeight: pw.FontWeight.bold)),
                margin: headConfig.margin,
                padding: headConfig.padding ??
                    pw.EdgeInsets.symmetric(vertical: 10)),
            alignment: pw.Alignment.centerLeft)
        : pw.SizedBox();
  }

  pw.Widget bulletItem(String value, TextPdfConfig bulletItemConfig,
      {bool showBullets = true, pw.TextStyle textStyle}) {
    if (bulletItemConfig == null) {
      bulletItemConfig = TextPdfConfig();
    }
    return bulletItemConfig.visibility
        ? pw.Container(
            margin: bulletItemConfig.margin,
            padding: bulletItemConfig.padding,
            alignment: pw.Alignment.centerLeft,
            child: pw.Text("${showBullets ? '\u2022 ' : ''}$value",
                style: pw.TextStyle(
                        color: bulletItemConfig.color ??
                            PdfColor.fromInt(0xff555555),
                        fontSize: bulletItemConfig.fontSize)
                    .merge(textStyle),
                softWrap: true,
                maxLines: 3))
        : pw.SizedBox();
  }

  void pageChanged(int page, int total) {
    setState(() {
      totalPage = total;
      currentPage = page + 1;
    });
  }
}

String pageFormat(PdfPageFormat pageFormat) {
  switch (pageFormat) {
    case PdfPageFormat.a3:
      return 'A3';
      break;
    case PdfPageFormat.a4:
      return 'A4';
      break;
    case PdfPageFormat.a5:
      return 'A5';
      break;
    case PdfPageFormat.legal:
      return 'Legal';
      break;
    case PdfPageFormat.letter:
      return 'Letter';
      break;
    case PdfPageFormat.undefined:
      return 'Undefined';
      break;
    case PdfPageFormat.roll57:
      return 'Roll 57';
      break;
    case PdfPageFormat.roll80:
      return 'Roll 80';
      break;
    default:
      return 'Nothing';
      break;
  }
}
