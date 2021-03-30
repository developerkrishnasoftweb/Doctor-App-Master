import 'package:getcure_doctor/Models/Appointments/DoctorAppointmentHistoryModel.dart';
import 'package:getcure_doctor/Models/PatientsVisitTableModels.dart';

class PatientVisitSync {
  List<PatientVisitSyncData> data;

  PatientVisitSync({this.data});

  PatientVisitSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PatientVisitSyncData>();
      json['data'].forEach((v) {
        data.add(new PatientVisitSyncData.fromJson(v));
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

class PatientVisitSyncData {
 int clinicDoctorId;
  String patientId;
  String patientName;
  int temperature;
  String bloodPressure;
  int pulse;
  int fee;
  int weight;
  List<BriefHistoryData> briefHistory;
  List<VisitReasonData> visitReason;
  List<ExaminationData> examination;
  List<DignosisData> diagnosis;
  List<MedicationData> medication;
  List<String> allergies;
  List<String> lifestyle;
  String bookingType;
  String visitType;
  String appointmentType;
  String bookedAt;
  String appointmentTime;
  dynamic presentTime;
  String bookedBy;
  dynamic bookedVia;
  dynamic updatedBy;
  bool isDoctorFeedback;
  bool isPatientFeedback;
  String createdAt;
  String updatedAt;
  Patient patient;

  PatientVisitSyncData(
      {
      this.clinicDoctorId,
      this.patientId,
      this.patientName,
      this.fee,
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

  PatientVisitSyncData.fromJson(Map<String, dynamic> json) {
    
    clinicDoctorId = json['clinic_doctor_id'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    temperature = json['temperature'];
    fee = json['fees'];
    bloodPressure = json['blood_pressure'];
    pulse = json['pulse'];
    weight = json['weight'];
    if (json['brief_history'] != null) {
      briefHistory = new List<BriefHistoryData>();
      json['brief_history'].forEach((v) {
        briefHistory.add(new BriefHistoryData.fromJson(v));
      });
    }
    if (json['visit_reason'] != null) {
      visitReason = new List<VisitReasonData>();
      json['visit_reason'].forEach((v) {
        visitReason.add(new VisitReasonData.fromJson(v));
      });
    }
    if (json['examination'] != null) {
      examination = new List<ExaminationData>();
      json['examination'].forEach((v) {
        examination.add(new ExaminationData.fromJson(v));
      });
    }
    if (json['diagnosis'] != null) {
      diagnosis = new List<DignosisData>();
      json['diagnosis'].forEach((v) {
        diagnosis.add(new DignosisData.fromJson(v));
      });
    }
    if (json['medication'] != null) {
      medication = new List<MedicationData>();
      json['medication'].forEach((v) {
        medication.add(new MedicationData.fromJson(v));
      });
    }
    allergies = json['allergies'].cast<String>();
    lifestyle = json['lifestyle'].cast<String>();
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
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['fees'] = this.fee;
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
    return data;
  }
}

// class Patient {
//   int id;
//   String name;
//   String patientId;
//   String mobileNo;
//   int age;
//   String gender;
//   String address;
//   String createdAt;
//   String updatedAt;

//   Patient(
//       {this.id,
//       this.name,
//       this.patientId,
//       this.mobileNo,
//       this.age,
//       this.gender,
//       this.address,
//       this.createdAt,
//       this.updatedAt});

//   Patient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     patientId = json['patient_id'];
//     mobileNo = json['mobile_no'];
//     age = json['age'];
//     gender = json['gender'];
//     address = json['address'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['patient_id'] = this.patientId;
//     data['mobile_no'] = this.mobileNo;
//     data['age'] = this.age;
//     data['gender'] = this.gender;
//     data['address'] = this.address;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }