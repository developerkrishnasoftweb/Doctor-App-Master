class ClinicDoctorModel {
  List<Data> data;

  ClinicDoctorModel({this.data});

  ClinicDoctorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String doctorName;
  int doctorId;
  List<DoctorTimings> doctorTimings;
  int clinicId;
  int patientsPerHour;
  int frontDeskId;
  int consultationFee;
  int emergencyFee;
  String createdAt;
  String updatedAt;
  Null doctor;
  Clinic clinic;

  Data(
      {this.id,
      this.doctorName,
      this.doctorId,
      this.doctorTimings,
      this.clinicId,
      this.patientsPerHour,
      this.frontDeskId,
      this.consultationFee,
      this.emergencyFee,
      this.createdAt,
      this.updatedAt,
      this.doctor,
      this.clinic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorName = json['doctor_name'];
    doctorId = json['doctor_id'];
    if (json['doctor_timings'] != null) {
      doctorTimings = new List<DoctorTimings>();
      json['doctor_timings'].forEach((v) {
        doctorTimings.add(new DoctorTimings.fromJson(v));
      });
    }
    clinicId = json['clinic_id'];
    patientsPerHour = json['patients_per_hour'];
    frontDeskId = json['front_desk_id'];
    consultationFee = json['consultation_fee'];
    emergencyFee = json['emergency_fee'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor = json['doctor'];
    clinic =
        json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_name'] = this.doctorName;
    data['doctor_id'] = this.doctorId;
    if (this.doctorTimings != null) {
      data['doctor_timings'] =
          this.doctorTimings.map((v) => v.toJson()).toList();
    }
    data['clinic_id'] = this.clinicId;
    data['patients_per_hour'] = this.patientsPerHour;
    data['front_desk_id'] = this.frontDeskId;
    data['consultation_fee'] = this.consultationFee;
    data['emergency_fee'] = this.emergencyFee;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['doctor'] = this.doctor;
    if (this.clinic != null) {
      data['clinic'] = this.clinic.toJson();
    }
    return data;
  }
}

class DoctorTimings {
  String day;
  String startTime;
  String breakStart;
  String breakEnd;
  String endTime;

  DoctorTimings(
      {this.day, this.startTime, this.breakStart, this.breakEnd, this.endTime});

  DoctorTimings.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['start_time'];
    breakStart = json['break_start'];
    breakEnd = json['break_end'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['start_time'] = this.startTime;
    data['break_start'] = this.breakStart;
    data['break_end'] = this.breakEnd;
    data['end_time'] = this.endTime;
    return data;
  }
}

class Clinic {
  int id;
  String name;
  String city;
  int cityId;
  List<Timings> timings;
  String address;
  String landmark;
  String pinCode;
  Null registrationNo;
  Null ownershipUrl;
  String getCureCode;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Clinic(
      {this.id,
      this.name,
      this.city,
      this.cityId,
      this.timings,
      this.address,
      this.landmark,
      this.pinCode,
      this.registrationNo,
      this.ownershipUrl,
      this.getCureCode,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    cityId = json['city_id'];
    if (json['timings'] != null) {
      timings = new List<Timings>();
      json['timings'].forEach((v) {
        timings.add(new Timings.fromJson(v));
      });
    }
    address = json['address'];
    landmark = json['landmark'];
    pinCode = json['pin_code'];
    registrationNo = json['registration_no'];
    ownershipUrl = json['ownership_url'];
    getCureCode = json['get_cure_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    if (this.timings != null) {
      data['timings'] = this.timings.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['pin_code'] = this.pinCode;
    data['registration_no'] = this.registrationNo;
    data['ownership_url'] = this.ownershipUrl;
    data['get_cure_code'] = this.getCureCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Timings {
  String day;
  String startTime;
  String breakStart;
  String breakEnd;
  String endTime;

  Timings(
      {this.day, this.startTime, this.breakStart, this.breakEnd, this.endTime});

  Timings.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['start_time'];
    breakStart = json['break_start'];
    breakEnd = json['break_end'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['start_time'] = this.startTime;
    data['break_start'] = this.breakStart;
    data['break_end'] = this.breakEnd;
    data['end_time'] = this.endTime;
    return data;
  }
}
