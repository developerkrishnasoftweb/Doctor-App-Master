import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfConfig {
  String id,
      doctorId,
      imageURL,
      somethingText1,
      somethingText2,
      somethingText3,
      createdAt,
      updatedAt;
  TextPdfConfig imageLable,
      nameLable,
      nameValue,
      visitTypeLabel,
      visitTypeValue,
      genderLable,
      genderValue,
      ageLable,
      ageValue,
      addressLable,
      addressValue,
      appointmentIdLable,
      appointmentIdValue,
      appointmentDateLable,
      appointmentDateValue,
      appointmentTimeLable,
      appointmentTimeValue,
      ghidLable,
      ghidValue,
      tokenNoLable,
      tokenNoValue,
      vitalsLable,
      vitalsValue,
      briefHistoryLable,
      briefHistoryValue,
      visitReasonsLable,
      visitReasonsValue,
      allergiesLable,
      allergiesValue,
      lifestyleLable,
      lifestyleValue,
      examinationLable,
      examinationKey,
      examinationValue,
      noticableLable,
      noticableValue,
      diagnosisLable,
      diagnosisValue,
      madicationLable,
      madicationValue,
      adviceLable,
      adviceValue,
      freeVisitDateLable,
      freeVisitDateValue;
  bool isActive, deletedAt;

  PdfConfig(
      {this.id,
      this.doctorId,
      this.imageURL,
      this.imageLable,
      this.nameLable,
      this.nameValue,
      this.visitTypeLabel,
      this.visitTypeValue,
      this.genderLable,
      this.genderValue,
      this.ageLable,
      this.ageValue,
      this.addressLable,
      this.addressValue,
      this.appointmentIdLable,
      this.appointmentIdValue,
      this.appointmentDateLable,
      this.appointmentDateValue,
      this.appointmentTimeLable,
      this.appointmentTimeValue,
      this.ghidLable,
      this.ghidValue,
      this.tokenNoLable,
      this.tokenNoValue,
      this.vitalsLable,
      this.vitalsValue,
      this.briefHistoryLable,
      this.briefHistoryValue,
      this.visitReasonsLable,
      this.visitReasonsValue,
      this.allergiesLable,
      this.allergiesValue,
      this.lifestyleLable,
      this.lifestyleValue,
      this.examinationLable,
      this.examinationKey,
      this.examinationValue,
      this.noticableLable,
      this.noticableValue,
      this.diagnosisLable,
      this.diagnosisValue,
      this.madicationLable,
      this.madicationValue,
      this.adviceLable,
      this.adviceValue,
      this.freeVisitDateLable,
      this.freeVisitDateValue,
      this.somethingText1,
      this.somethingText2,
      this.somethingText3,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  PdfConfig.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    doctorId = json['doctor_id']?.toString();
    imageURL = json['imageURL']?.toString();
    imageLable = TextPdfConfig.fromJson(json['imageLable']);
    nameLable = TextPdfConfig.fromJson(json['nameLable']);
    nameValue = TextPdfConfig.fromJson(json['nameValue']);
    visitTypeLabel = TextPdfConfig.fromJson(json['visitTypeLabel']);
    visitTypeValue = TextPdfConfig.fromJson(json['visitTypeValue']);
    genderLable = TextPdfConfig.fromJson(json['genderLable']);
    genderValue = TextPdfConfig.fromJson(json['genderValue']);
    ageLable = TextPdfConfig.fromJson(json['ageLable']);
    ageValue = TextPdfConfig.fromJson(json['ageValue']);
    addressLable = TextPdfConfig.fromJson(json['addressLable']);
    addressValue = TextPdfConfig.fromJson(json['addressValue']);
    appointmentIdLable = TextPdfConfig.fromJson(json['appointmentIdLable']);
    appointmentIdValue = TextPdfConfig.fromJson(json['appointmentIdValue']);
    appointmentDateLable = TextPdfConfig.fromJson(json['appointmentDateLable']);
    appointmentDateValue = TextPdfConfig.fromJson(json['appointmentDateValue']);
    appointmentTimeLable = TextPdfConfig.fromJson(json['appointmentTimeLable']);
    appointmentTimeValue = TextPdfConfig.fromJson(json['appointmentTimeValue']);
    ghidLable = TextPdfConfig.fromJson(json['ghidLable']);
    ghidValue = TextPdfConfig.fromJson(json['ghidValue']);
    tokenNoLable = TextPdfConfig.fromJson(json['tokenNoLable']);
    tokenNoValue = TextPdfConfig.fromJson(json['tokenNoValue']);
    vitalsLable = TextPdfConfig.fromJson(json['vitalsLable']);
    vitalsValue = TextPdfConfig.fromJson(json['vitalsValue']);
    briefHistoryLable = TextPdfConfig.fromJson(json['briefHistoryLable']);
    briefHistoryValue = TextPdfConfig.fromJson(json['briefHistoryValue']);
    visitReasonsLable = TextPdfConfig.fromJson(json['visitReasonsLable']);
    visitReasonsValue = TextPdfConfig.fromJson(json['visitReasonsValue']);
    allergiesLable = TextPdfConfig.fromJson(json['allergiesLable']);
    allergiesValue = TextPdfConfig.fromJson(json['allergiesValue']);
    lifestyleLable = TextPdfConfig.fromJson(json['lifestyleLable']);
    lifestyleValue = TextPdfConfig.fromJson(json['lifestyleValue']);
    examinationLable = TextPdfConfig.fromJson(json['examinationLable']);
    examinationKey = TextPdfConfig.fromJson(json['examinationKey']);
    examinationValue = TextPdfConfig.fromJson(json['examinationValue']);
    noticableLable = TextPdfConfig.fromJson(json['noticableLable']);
    noticableValue = TextPdfConfig.fromJson(json['noticableValue']);
    diagnosisLable = TextPdfConfig.fromJson(json['diagnosisLable']);
    diagnosisValue = TextPdfConfig.fromJson(json['diagnosisValue']);
    madicationLable = TextPdfConfig.fromJson(json['madicationLable']);
    madicationValue = TextPdfConfig.fromJson(json['madicationValue']);
    adviceLable = TextPdfConfig.fromJson(json['adviceLable']);
    adviceValue = TextPdfConfig.fromJson(json['adviceValue']);
    freeVisitDateLable = TextPdfConfig.fromJson(json['freeVisitDateLable']);
    freeVisitDateValue = TextPdfConfig.fromJson(json['freeVisitDateValue']);
    somethingText1 = json['somethingText1'];
    somethingText2 = json['somethingText2'];
    somethingText3 = json['somethingText3'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}

class TextPdfConfig {
  final pw.EdgeInsets margin, padding;
  final PdfColor color;
  final bool visibility;
  final double fontSize;

  const TextPdfConfig(
      {this.margin = pw.EdgeInsets.zero,
      this.padding = pw.EdgeInsets.zero,
      this.color = const PdfColor(0, 0, 0),
      this.visibility = true,
      this.fontSize = 18});

  factory TextPdfConfig.fromJson(String source) {
    Map<String, dynamic> json = {};
    if (source != null) {
      if (source.isNotEmpty) {
        json = jsonDecode(source);
      }
    }
    return TextPdfConfig(
        color: colorByCode(json['color']),
        padding: edgeInsets(json['padding']),
        margin: edgeInsets(json['margin']),
        visibility: json['visibility'] ?? true,
        fontSize: json['fontSize'] ?? 18);
  }
}

PdfColor colorByCode(data) {
  List<double> colorCode = [];
  if (data != null) {
    data.forEach((v) {
      colorCode.add(v);
    });
  }
  if (colorCode != null) {
    if (colorCode.length != 4) {
      colorCode = [0.0, 0.0, 0.0, 0.0];
    }
  }
  return PdfColor(colorCode[0], colorCode[1], colorCode[2], colorCode[3]);
}

pw.EdgeInsets edgeInsets(data) {
  List<double> values = [];
  if (data != null) {
    data.forEach((v) {
      values.add(v);
    });
  }
  if (values != null) {
    if (values.length != 4) {
      values = [0.0, 0.0, 0.0, 0.0];
    }
  }
  return pw.EdgeInsets.fromLTRB(values[0], values[1], values[2], values[3]);
}
