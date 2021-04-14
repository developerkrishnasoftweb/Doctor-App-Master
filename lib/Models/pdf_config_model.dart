class PdfConfig {
  String id, doctorId, imageURL, imageLable, nameLable, nameValue, genderLable, genderValue, ageLable, ageValue, addressLable, addressValue, appointmentIdLable, appointmentIdValue, appointmentDateLable, appointmentDateValue, appointmentTimeLable, appointmentTimeValue, ghidLable, ghidValue, tokenNoLable, tokenNoValue, vitalsLable, vitalsValue, briefHistoryLable, briefHistoryValue, visitReasonsLable, visitReasonsValue, allergiesLable, allergiesValue, lifestyleLable, lifestyleValue, examinationLable, examinationValue, noticableLable, noticableValue, diagnosisLable, diagnosisValue, madicationLable, madicationValue, adviceLable, adviceValue, freeVisitDateLable, freeVisitDateValue, somethingText1, somethingText2, somethingText3, createdAt, updatedAt;
  bool isActive, deletedAt;

  PdfConfig(
      {this.id,
        this.doctorId,
        this.imageURL,
        this.imageLable,
        this.nameLable,
        this.nameValue,
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
    imageLable = json['imageLable']?.toString();
    nameLable = json['nameLable']?.toString();
    nameValue = json['nameValue']?.toString();
    genderLable = json['genderLable']?.toString();
    genderValue = json['genderValue']?.toString();
    ageLable = json['ageLable']?.toString();
    ageValue = json['ageValue']?.toString();
    addressLable = json['addressLable']?.toString();
    addressValue = json['addressValue']?.toString();
    appointmentIdLable = json['appointmentIdLable']?.toString();
    appointmentIdValue = json['appointmentIdValue']?.toString();
    appointmentDateLable = json['appointmentDateLable']?.toString();
    appointmentDateValue = json['appointmentDateValue']?.toString();
    appointmentTimeLable = json['appointmentTimeLable']?.toString();
    appointmentTimeValue = json['appointmentTimeValue']?.toString();
    ghidLable = json['ghidLable']?.toString();
    ghidValue = json['ghidValue']?.toString();
    tokenNoLable = json['tokenNoLable']?.toString();
    tokenNoValue = json['tokenNoValue']?.toString();
    vitalsLable = json['vitalsLable']?.toString();
    vitalsValue = json['vitalsValue']?.toString();
    briefHistoryLable = json['briefHistoryLable']?.toString();
    briefHistoryValue = json['briefHistoryValue']?.toString();
    visitReasonsLable = json['visitReasonsLable']?.toString();
    visitReasonsValue = json['visitReasonsValue']?.toString();
    allergiesLable = json['allergiesLable']?.toString();
    allergiesValue = json['allergiesValue']?.toString();
    lifestyleLable = json['lifestyleLable']?.toString();
    lifestyleValue = json['lifestyleValue']?.toString();
    examinationLable = json['examinationLable']?.toString();
    examinationValue = json['examinationValue']?.toString();
    noticableLable = json['noticableLable']?.toString();
    noticableValue = json['noticableValue']?.toString();
    diagnosisLable = json['diagnosisLable']?.toString();
    diagnosisValue = json['diagnosisValue']?.toString();
    madicationLable = json['madicationLable']?.toString();
    madicationValue = json['madicationValue']?.toString();
    adviceLable = json['adviceLable']?.toString();
    adviceValue = json['adviceValue']?.toString();
    freeVisitDateLable = json['freeVisitDateLable']?.toString();
    freeVisitDateValue = json['freeVisitDateValue']?.toString();
    somethingText1 = json['somethingText1']?.toString();
    somethingText2 = json['somethingText2']?.toString();
    somethingText3 = json['somethingText3']?.toString();
    isActive = json['is_active'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['imageURL'] = this.imageURL;
    data['imageLable'] = this.imageLable;
    data['nameLable'] = this.nameLable;
    data['nameValue'] = this.nameValue;
    data['genderLable'] = this.genderLable;
    data['genderValue'] = this.genderValue;
    data['ageLable'] = this.ageLable;
    data['ageValue'] = this.ageValue;
    data['addressLable'] = this.addressLable;
    data['addressValue'] = this.addressValue;
    data['appointmentIdLable'] = this.appointmentIdLable;
    data['appointmentIdValue'] = this.appointmentIdValue;
    data['appointmentDateLable'] = this.appointmentDateLable;
    data['appointmentDateValue'] = this.appointmentDateValue;
    data['appointmentTimeLable'] = this.appointmentTimeLable;
    data['appointmentTimeValue'] = this.appointmentTimeValue;
    data['ghidLable'] = this.ghidLable;
    data['ghidValue'] = this.ghidValue;
    data['tokenNoLable'] = this.tokenNoLable;
    data['tokenNoValue'] = this.tokenNoValue;
    data['vitalsLable'] = this.vitalsLable;
    data['vitalsValue'] = this.vitalsValue;
    data['briefHistoryLable'] = this.briefHistoryLable;
    data['briefHistoryValue'] = this.briefHistoryValue;
    data['visitReasonsLable'] = this.visitReasonsLable;
    data['visitReasonsValue'] = this.visitReasonsValue;
    data['allergiesLable'] = this.allergiesLable;
    data['allergiesValue'] = this.allergiesValue;
    data['lifestyleLable'] = this.lifestyleLable;
    data['lifestyleValue'] = this.lifestyleValue;
    data['examinationLable'] = this.examinationLable;
    data['examinationValue'] = this.examinationValue;
    data['noticableLable'] = this.noticableLable;
    data['noticableValue'] = this.noticableValue;
    data['diagnosisLable'] = this.diagnosisLable;
    data['diagnosisValue'] = this.diagnosisValue;
    data['madicationLable'] = this.madicationLable;
    data['madicationValue'] = this.madicationValue;
    data['adviceLable'] = this.adviceLable;
    data['adviceValue'] = this.adviceValue;
    data['freeVisitDateLable'] = this.freeVisitDateLable;
    data['freeVisitDateValue'] = this.freeVisitDateValue;
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