class DoctorAppointmentHistoryModel {
  List<HistoryData> data;

  DoctorAppointmentHistoryModel({this.data});

  DoctorAppointmentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<HistoryData>();
      json['data'].forEach((v) {
        data.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  int id;
  String appointmentId;
  int clinicDoctorId;
  String patientId;
  String patientName;
  Null doctorName;
  Null clinicName;
  Null state;
  int temperature;
  String bloodPressure;
  int pulse;
  int weight;
  List<BriefHistory> briefHistory;
  List<VisitReason> visitReason;
  List<Examination> examination;
  List<Diagnosis> diagnosis;
  List<Medication> medication;
  List<String> allergies;
  List<String> lifestyle;
  String bookingType;
  String visitType;
  String appointmentType;
  String bookedAt;
  String appointmentTime;
  Null presentTime;
  String bookedBy;
  Null bookedVia;
  String updatedBy;
  bool isDoctorFeedback;
  bool isPatientFeedback;
  String createdAt;
  String updatedAt;
  Patient patient;

  HistoryData(
      {this.id,
      this.appointmentId,
      this.clinicDoctorId,
      this.patientId,
      this.patientName,
      this.doctorName,
      this.clinicName,
      this.state,
      this.temperature,
      this.bloodPressure,
      this.pulse,
      this.weight,
      this.briefHistory,
      this.visitReason,
      this.examination,
      this.diagnosis,
      this.medication,
      this.allergies,
      this.lifestyle,
      this.bookingType,
      this.visitType,
      this.appointmentType,
      this.bookedAt,
      this.appointmentTime,
      this.presentTime,
      this.bookedBy,
      this.bookedVia,
      this.updatedBy,
      this.isDoctorFeedback,
      this.isPatientFeedback,
      this.createdAt,
      this.updatedAt,
      this.patient});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentId = json['appointment_id'];
    clinicDoctorId = json['clinic_doctor_id'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    doctorName = json['doctor_name'];
    clinicName = json['clinic_name'];
    state = json['state'];
    temperature = json['temperature'];
    bloodPressure = json['blood_pressure'];
    pulse = json['pulse'];
    weight = json['weight'];
    if (json['brief_history'] != null) {
      briefHistory = new List<BriefHistory>();
      json['brief_history'].forEach((v) {
        briefHistory.add(new BriefHistory.fromJson(v));
      });
    }
    if (json['visit_reason'] != null) {
      visitReason = new List<VisitReason>();
      json['visit_reason'].forEach((v) {
        visitReason.add(new VisitReason.fromJson(v));
      });
    }
    if (json['examination'] != null) {
      examination = new List<Examination>();
      json['examination'].forEach((v) {
        examination.add(new Examination.fromJson(v));
      });
    }
    if (json['diagnosis'] != null) {
      diagnosis = new List<Diagnosis>();
      json['diagnosis'].forEach((v) {
        diagnosis.add(new Diagnosis.fromJson(v));
      });
    }
    if (json['medication'] != null) {
      medication = new List<Medication>();
      json['medication'].forEach((v) {
        medication.add(new Medication.fromJson(v));
      });
    }
    allergies = json['allergies'].cast<String>();
    lifestyle = json['lifestyle'].cast<String>();
    // if (json['allergies'] != null) {
    //   allergies = new List<AllergyData>();
    //   json['allergies'].forEach((v) {
    //     allergies.add(new AllergyData.fromJson(v));
    //   });
    // }
    // if (json['lifestyle'] != null) {
    //   lifestyle = new List<LifeStyleData>();
    //   json['lifestyle'].forEach((v) {
    //     lifestyle.add(new LifeStyleData.fromJson(v));
    //   });
    // }
    bookingType = json['booking_type'];
    visitType = json['visit_type'];
    appointmentType = json['appointment_type'];
    bookedAt = json['booked_at'];
    appointmentTime = json['appointment_time'];
    presentTime = json['present_time'];
    bookedBy = json['booked_by'];
    bookedVia = json['booked_via'];
    updatedBy = json['updated_by'];
    isDoctorFeedback = json['is_doctor_feedback'];
    isPatientFeedback = json['is_patient_feedback'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['doctor_name'] = this.doctorName;
    data['clinic_name'] = this.clinicName;
    data['state'] = this.state;
    data['temperature'] = this.temperature;
    data['blood_pressure'] = this.bloodPressure;
    data['pulse'] = this.pulse;
    data['weight'] = this.weight;
    if (this.briefHistory != null) {
      data['brief_history'] = this.briefHistory.map((v) => v.toJson()).toList();
    }
    if (this.visitReason != null) {
      data['visit_reason'] = this.visitReason.map((v) => v.toJson()).toList();
    }
    if (this.examination != null) {
      data['examination'] = this.examination.map((v) => v.toJson()).toList();
    }
    if (this.diagnosis != null) {
      data['diagnosis'] = this.diagnosis.map((v) => v.toJson()).toList();
    }
    if (this.medication != null) {
      data['medication'] = this.medication.map((v) => v.toJson()).toList();
    }
    // if (this.allergies != null) {
    //   data['allergies'] = this.allergies.map((v) => v.toJson()).toList();
    // }
    // if (this.lifestyle != null) {
    //   data['lifestyle'] = this.lifestyle.map((v) => v.toJson()).toList();
    // }
    data['allergies'] = this.allergies;
    data['lifestyle'] = this.lifestyle;
    data['booking_type'] = this.bookingType;
    data['visit_type'] = this.visitType;
    data['appointment_type'] = this.appointmentType;
    data['booked_at'] = this.bookedAt;
    data['appointment_time'] = this.appointmentTime;
    data['present_time'] = this.presentTime;
    data['booked_by'] = this.bookedBy;
    data['booked_via'] = this.bookedVia;
    data['updated_by'] = this.updatedBy;
    data['is_doctor_feedback'] = this.isDoctorFeedback;
    data['is_patient_feedback'] = this.isPatientFeedback;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    return data;
  }
}

class BriefHistory {
  String title;
  String date;
  String visibleTill;
  bool isCured;

  BriefHistory({this.title, this.date, this.visibleTill, this.isCured});

  BriefHistory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class VisitReason {
  String title;
  String date;
  String visibleTill;
  bool isCured;

  VisitReason({this.title, this.date, this.visibleTill, this.isCured});

  VisitReason.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class AllergyData {
  int id;
  int clinicDoctorId;
  int doctorId;
  String title;
  String type;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isCured;

  AllergyData(
      {this.id,
      this.clinicDoctorId,
      this.doctorId,
      this.title,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isCured});

  AllergyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicDoctorId = json['clinic_doctor_id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class LifeStyleData {
  int id;
  int clinicDoctorId;
  int doctorId;
  String title;
  String type;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isCured;

  LifeStyleData(
      {this.id,
      this.clinicDoctorId,
      this.doctorId,
      this.title,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isCured});

  LifeStyleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicDoctorId = json['clinic_doctor_id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['is_cured'] = this.isCured;
    return data;
  }
}


class Examination {
  int examinationId;
  String title;
  List<Parameters> parameters;
  String status;

  Examination({this.examinationId, this.title, this.parameters, this.status});

  Examination.fromJson(Map<String, dynamic> json) {
    examinationId = json['examination_id'];
    title = json['title'];
    if (json['parameters'] != null) {
      parameters = new List<Parameters>();
      json['parameters'].forEach((v) {
        parameters.add(new Parameters.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examination_id'] = this.examinationId;
    data['title'] = this.title;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Diagnosis {
  String title;
  String date;
  String visibleTill;
  bool isCured;

  Diagnosis({this.title, this.date, this.visibleTill, this.isCured});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class Parameters {
  String title;
  String type;
  List<String> references;
  String unit;
  String method;
  String sample;
  List<dynamic> bioReference;
  List<dynamic> result;

  Parameters(
      {this.title,
      this.type,
      this.references,
      this.unit,
      this.method,
      this.sample,
      this.bioReference,
      this.result});

  Parameters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    references = json['references'].cast<String>();
    unit = json['unit'];
    method = json['method'];
    sample = json['sample'];
    bioReference=json['bio_reference'].cast<String>();
    result = json['result'].cast<String>();
    // if (json['bio_reference'] != null) {
    //   bioReference = new List<Null>();
    //   json['bio_reference'].forEach((v) {
    //     bioReference.add(new dynamic.fromJson(v));
    //   });
    // }
    // if (json['result'] != null) {
    //   result = new List<Null>();
    //   json['result'].forEach((v) {
    //     result.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['references'] = this.references;
    data['unit'] = this.unit;
    data['method'] = this.method;
    data['sample'] = this.sample;
    data['bio_reference'] = this.bioReference;
    data['result'] = this.result;
    // if (this.bioReference != null) {
    //   data['bio_reference'] = this.bioReference.map((v) => v.toJson()).toList();
    // }
    // if (this.result != null) {
    //   data['result'] = this.result.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Medication {
  String disease;
  int symptomId;
  List<Medicines> medicines;

  Medication({this.disease, this.symptomId, this.medicines});

  Medication.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
    symptomId = json['symptom_id'];
    if (json['medicines'] != null) {
      medicines = new List<Medicines>();
      json['medicines'].forEach((v) {
        medicines.add(new Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease'] = this.disease;
    data['symptom_id'] = this.symptomId;
    if (this.medicines != null) {
      data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines {
  int medicineId;
  String title;
  String dose;
  String direction;
  String duration;
  String route;
  String unit;
  String frequency;

  Medicines(
      {this.medicineId,
      this.title,
      this.dose,
      this.direction,
      this.duration,
      this.route,
      this.unit,
      this.frequency});

  Medicines.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    title = json['title'];
    dose = json['dose'];
    direction = json['direction'];
    duration = json['duration'];
    route = json['route'];
    unit = json['unit'];
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_id'] = this.medicineId;
    data['title'] = this.title;
    data['dose'] = this.dose;
    data['direction'] = this.direction;
    data['duration'] = this.duration;
    data['route'] = this.route;
    data['unit'] = this.unit;
    data['frequency'] = this.frequency;
    return data;
  }
}

class Patient {
  int id;
  String name;
  String patientId;
  String mobileNo;
  int age;
  String gender;
  String address;
  String createdAt;
  String updatedAt;

  Patient(
      {this.id,
      this.name,
      this.patientId,
      this.mobileNo,
      this.age,
      this.gender,
      this.address,
      this.createdAt,
      this.updatedAt});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    patientId = json['patient_id'];
    mobileNo = json['mobile_no'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['patient_id'] = this.patientId;
    data['mobile_no'] = this.mobileNo;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}