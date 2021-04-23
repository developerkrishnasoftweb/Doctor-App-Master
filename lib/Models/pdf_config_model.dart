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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['imageURL'] = this.imageURL;
    data['imageLable'] = this.imageLable.toJson();
    data['nameLable'] = this.nameLable.toJson();
    data['nameValue'] = this.nameValue.toJson();
    data['genderLable'] = this.genderLable.toJson();
    data['genderValue'] = this.genderValue.toJson();
    data['ageLable'] = this.ageLable.toJson();
    data['ageValue'] = this.ageValue.toJson();
    data['addressLable'] = this.addressLable.toJson();
    data['addressValue'] = this.addressValue.toJson();
    data['appointmentIdLable'] = this.appointmentIdLable.toJson();
    data['appointmentIdValue'] = this.appointmentIdValue.toJson();
    data['appointmentDateLable'] = this.appointmentDateLable.toJson();
    data['appointmentDateValue'] = this.appointmentDateValue.toJson();
    data['appointmentTimeLable'] = this.appointmentTimeLable.toJson();
    data['appointmentTimeValue'] = this.appointmentTimeValue.toJson();
    data['ghidLable'] = this.ghidLable.toJson();
    data['ghidValue'] = this.ghidValue.toJson();
    data['tokenNoLable'] = this.tokenNoLable.toJson();
    data['tokenNoValue'] = this.tokenNoValue.toJson();
    data['vitalsLable'] = this.vitalsLable.toJson();
    data['vitalsValue'] = this.vitalsValue.toJson();
    data['briefHistoryLable'] = this.briefHistoryLable.toJson();
    data['briefHistoryValue'] = this.briefHistoryValue.toJson();
    data['visitReasonsLable'] = this.visitReasonsLable.toJson();
    data['visitReasonsValue'] = this.visitReasonsValue.toJson();
    data['allergiesLable'] = this.allergiesLable.toJson();
    data['allergiesValue'] = this.allergiesValue.toJson();
    data['lifestyleLable'] = this.lifestyleLable.toJson();
    data['lifestyleValue'] = this.lifestyleValue.toJson();
    data['examinationLable'] = this.examinationLable.toJson();
    data['examinationValue'] = this.examinationValue.toJson();
    data['noticableLable'] = this.noticableLable.toJson();
    data['noticableValue'] = this.noticableValue.toJson();
    data['diagnosisLable'] = this.diagnosisLable.toJson();
    data['diagnosisValue'] = this.diagnosisValue.toJson();
    data['madicationLable'] = this.madicationLable.toJson();
    data['madicationValue'] = this.madicationValue.toJson();
    data['adviceLable'] = this.adviceLable.toJson();
    data['adviceValue'] = this.adviceValue.toJson();
    data['freeVisitDateLable'] = this.freeVisitDateLable.toJson();
    data['freeVisitDateValue'] = this.freeVisitDateValue.toJson();
    data['somethingText1'] = this.somethingText1;
    data['somethingText2'] = this.somethingText2;
    data['somethingText3'] = this.somethingText3;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class TextPdfConfig {
  final pw.TextStyle textStyle;
  final pw.EdgeInsets margin, padding;
  final PdfColor color;
  final bool visibility;

  const TextPdfConfig(
      {this.textStyle,
      this.margin = pw.EdgeInsets.zero,
      this.padding = pw.EdgeInsets.zero,
      this.color = const PdfColor(0, 0, 0),
      this.visibility = false});

  factory TextPdfConfig.fromJson(String source) {
    Map<String, dynamic> json = {};
    if (source != null) {
      if (source.isNotEmpty) {
        json = jsonDecode(source);
      }
    }
    return TextPdfConfig(
        color: json['color'] ?? const PdfColor(0, 0, 0),
        padding: json['padding'] ?? pw.EdgeInsets.zero,
        margin: json['margin'] ?? pw.EdgeInsets.zero,
        textStyle: json['textStyle'],
        visibility: json['visibility'] ?? true);
  }

  Map<String, dynamic> toJson() {
    return {
      'color': this.color,
      'padding': this.padding,
      'margin': this.margin,
      'textStyle': this.textStyle,
      'visibility': this.visibility
    };
  }
}
