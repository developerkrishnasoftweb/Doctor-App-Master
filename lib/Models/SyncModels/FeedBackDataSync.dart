import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';

class FeedBackSync {
  List<Feedbacks> feedbacks;

  FeedBackSync({this.feedbacks});

  FeedBackSync.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = new List<Feedbacks>();
      json['feedbacks'].forEach((v) {
        feedbacks.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedbacks {
  String patientId;
  int clinicDoctorId;
  String appointmentTime;
  List<Feedback> feedback;

  Feedbacks(
      {this.patientId,
      this.clinicDoctorId,
      this.appointmentTime,
      this.feedback});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    clinicDoctorId = json['clinic_doctor_id'];
    appointmentTime = json['appointment_time'];
    if (json['feedback'] != null) {
      feedback = new List<Feedback>();
      json['feedback'].forEach((v) {
        feedback.add(new Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['appointment_time'] = this.appointmentTime;
    if (this.feedback != null) {
      data['feedback'] = this.feedback.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedback {
  String question;
  String option;
  List<PrescribedMedicines> medicine;

  Feedback({this.question, this.option, this.medicine});

  Feedback.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    option = json['option'];
    if (json['medicine'] != null) {
      medicine = new List<PrescribedMedicines>();
      json['medicine'].forEach((v) {
        medicine.add(new PrescribedMedicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['option'] = this.option;
    if (this.medicine != null) {
      data['medicine'] = this.medicine.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineSync {
  String title;
  String dose;
  String unit;
  String route;
  String frequency;
  String direction;
  String duration;

  MedicineSync(
      {this.title,
      this.dose,
      this.unit,
      this.route,
      this.frequency,
      this.direction,
      this.duration});

  MedicineSync.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dose = json['dose'];
    unit = json['unit'];
    route = json['route'];
    frequency = json['frequency'];
    direction = json['direction'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dose'] = this.dose;
    data['unit'] = this.unit;
    data['route'] = this.route;
    data['frequency'] = this.frequency;
    data['direction'] = this.direction;
    data['duration'] = this.duration;
    return data;
  }
}



class FeedbackAPISync {
  List<FeedbackAPISyncData> feedbacks;

  FeedbackAPISync({this.feedbacks});

  FeedbackAPISync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      feedbacks = new List<FeedbackAPISyncData>();
      json['data'].forEach((v) {
        feedbacks.add(new FeedbackAPISyncData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbacks != null) {
      data['data'] = this.feedbacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedbackAPISyncData {
  List<PrescribedMedicines> medicine;
  int id;
  int clinicDoctorId;
  int patientVisitId;
  String question;
  String option;
  String filler;
  String createdAt;
  String updatedAt;

  FeedbackAPISyncData(
      {this.medicine,
      this.id,
      this.clinicDoctorId,
      this.patientVisitId,
      this.question,
      this.option,
      this.filler,
      this.createdAt,
      this.updatedAt});

  FeedbackAPISyncData.fromJson(Map<String, dynamic> json) {
    if (json['medicine'] != null) {
      medicine = new List<PrescribedMedicines>();
      json['medicine'].forEach((v) {
        medicine.add(new PrescribedMedicines.fromJson(v));
      });
    }
    id = json['id'];
    clinicDoctorId = json['clinic_doctor_id'];
    patientVisitId = json['patient_visit_id'];
    question = json['question'];
    option = json['option'];
    filler = json['filler'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicine != null) {
      data['medicine'] = this.medicine.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['patient_visit_id'] = this.patientVisitId;
    data['question'] = this.question;
    data['option'] = this.option;
    data['filler'] = this.filler;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}