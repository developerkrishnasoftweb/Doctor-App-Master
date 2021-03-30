class DoctorLogin {
  String token;
  DoctorLoginData data;

  DoctorLogin({this.token, this.data});

  DoctorLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['data'] != null ? new DoctorLoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GetMyProfile {
  DoctorLoginData data;

  GetMyProfile({this.data});

  GetMyProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DoctorLoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DoctorLoginData {
  int id;
  String name;
  int age;
  String gender;
  String degree;
  String email;
  String password;
  String mobileNo;
  String language;
  String experience;
  String designation;
  String imageUrl;
  List<String> specialities;
  bool isActive;
  String getCureCode;
  dynamic identityVerificationUrl;
  List<String> holidays;
  String createdAt;
  String updatedAt;
  List<ClinicDoctor> clinicDoctor;
  Null clinics;

  DoctorLoginData(
      {this.id,
      this.name,
      this.age,
      this.gender,
      this.degree,
      this.email,
      this.password,
      this.mobileNo,
      this.language,
      this.experience,
      this.designation,
      this.imageUrl,
      this.specialities,
      this.isActive,
      this.getCureCode,
      this.identityVerificationUrl,
      this.holidays,
      this.createdAt,
      this.updatedAt,
      this.clinicDoctor,
      this.clinics});

  DoctorLoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    degree = json['degree'];
    email = json['email'];
    password = json['password'];
    mobileNo = json['mobile_no'];
    language = json['language'];
    experience = json['experience'];
    designation = json['designation'];
    imageUrl = json['image_url'];
    specialities = json['specialities'].cast<String>();
    isActive = json['is_active'];
    getCureCode = json['get_cure_code'];
    identityVerificationUrl = json['identity_verification_url'];
    holidays = json['holidays'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['clinicDoctor'] != null) {
      clinicDoctor = new List<ClinicDoctor>();
      json['clinicDoctor'].forEach((v) {
        clinicDoctor.add(new ClinicDoctor.fromJson(v));
      });
    }
    clinics = json['clinics'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['degree'] = this.degree;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile_no'] = this.mobileNo;
    data['language'] = this.language;
    data['experience'] = this.experience;
    data['designation'] = this.designation;
    data['image_url'] = this.imageUrl;
    data['specialities'] = this.specialities;
    data['is_active'] = this.isActive;
    data['get_cure_code'] = this.getCureCode;
    data['identity_verification_url'] = this.identityVerificationUrl;
    data['holidays'] = this.holidays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.clinicDoctor != null) {
      data['clinicDoctor'] = this.clinicDoctor.map((v) => v.toJson()).toList();
    }
    data['clinics'] = this.clinics;
    return data;
  }
}

class ClinicDoctor {
  int id;
  int clinicId;
  int doctorId;
  String doctorName;
  int frontDeskId;
  int consultationFee;
  int emergencyFee;
  int onlineCharge;
  int paidVisitCharge;
  int freeVisitCharge;
  int onCallPaidVisitCharge;
  int onCallFreeVisitCharge;
  int followUpAppointments;
  int followUpDays;
  int slotTime;
  List<DoctorTimings> doctorTimings;
  List<String> medicineCategories;
  List<String> medicineDoses;
  List<String> medicineUnits;
  List<String> medicineRoutes;
  List<String> medicineFrequencies;
  List<String> medicineDirections;
  List<String> medicineDurations;
  String createdAt;
  String updatedAt;
  Null doctor;
  Clinic clinic;

  ClinicDoctor(
      {this.id,
      this.clinicId,
      this.doctorId,
      this.doctorName,
      this.frontDeskId,
      this.consultationFee,
      this.emergencyFee,
      this.onlineCharge,
      this.paidVisitCharge,
      this.freeVisitCharge,
      this.onCallPaidVisitCharge,
      this.onCallFreeVisitCharge,
      this.followUpAppointments,
      this.followUpDays,
      this.slotTime,
      this.doctorTimings,
      this.medicineCategories,
      this.medicineDoses,
      this.medicineUnits,
      this.medicineRoutes,
      this.medicineFrequencies,
      this.medicineDirections,
      this.medicineDurations,
      this.createdAt,
      this.updatedAt,
      this.doctor,
      this.clinic});

  ClinicDoctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicId = json['clinic_id'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    frontDeskId = json['front_desk_id'];
    consultationFee = json['consultation_fee'];
    emergencyFee = json['emergency_fee'];
    onlineCharge = json['online_charge'];
    paidVisitCharge = json['paid_visit_charge'];
    freeVisitCharge = json['free_visit_charge'];
    onCallPaidVisitCharge = json['on_call_paid_visit_charge'];
    onCallFreeVisitCharge = json['on_call_free_visit_charge'];
    followUpAppointments = json['follow_up_appointments'];
    followUpDays = json['follow_up_days'];
    slotTime = json['slot_time'];
    if (json['doctor_timings'] != null) {
      doctorTimings = new List<DoctorTimings>();
      json['doctor_timings'].forEach((v) {
        doctorTimings.add(new DoctorTimings.fromJson(v));
      });
    }
    medicineCategories = json['medicine_categories'].cast<String>();
    medicineDoses = json['medicine_doses'].cast<String>();
    medicineUnits = json['medicine_units'].cast<String>();
    medicineRoutes = json['medicine_routes'].cast<String>();
    medicineFrequencies = json['medicine_frequencies'].cast<String>();
    medicineDirections = json['medicine_directions'].cast<String>();
    medicineDurations = json['medicine_durations'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor = json['doctor'];
    clinic =
        json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_id'] = this.clinicId;
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['front_desk_id'] = this.frontDeskId;
    data['consultation_fee'] = this.consultationFee;
    data['emergency_fee'] = this.emergencyFee;
    data['online_charge'] = this.onlineCharge;
    data['paid_visit_charge'] = this.paidVisitCharge;
    data['free_visit_charge'] = this.freeVisitCharge;
    data['on_call_paid_visit_charge'] = this.onCallPaidVisitCharge;
    data['on_call_free_visit_charge'] = this.onCallFreeVisitCharge;
    data['follow_up_appointments'] = this.followUpAppointments;
    data['follow_up_days'] = this.followUpDays;
    data['slot_time'] = this.slotTime;
    if (this.doctorTimings != null) {
      data['doctor_timings'] =
          this.doctorTimings.map((v) => v.toJson()).toList();
    }
    data['medicine_categories'] = this.medicineCategories;
    data['medicine_doses'] = this.medicineDoses;
    data['medicine_units'] = this.medicineUnits;
    data['medicine_routes'] = this.medicineRoutes;
    data['medicine_frequencies'] = this.medicineFrequencies;
    data['medicine_directions'] = this.medicineDirections;
    data['medicine_durations'] = this.medicineDurations;
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
  List<Slots> slots;

  DoctorTimings({this.day, this.slots});

  DoctorTimings.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['slots'] != null) {
      slots = new List<Slots>();
      json['slots'].forEach((v) {
        slots.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.slots != null) {
      data['slots'] = this.slots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  String startTime;
  String endTime;
  int noOfPatients;

  Slots({this.startTime, this.endTime, this.noOfPatients});

  Slots.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    noOfPatients = json['no_of_patients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['no_of_patients'] = this.noOfPatients;
    return data;
  }
  String toString(){
    return startTime + " - " + endTime + " - " + noOfPatients.toString(); 
  }
}

class Clinic {
  int id;
  String name;
  String type;
  String establishmentYear;
  int noOfBeds;
  int noOfDoctors;
  String state;
  int stateId;
  String timings;
  String about;
  List<String> specialities;
  String address;
  String pinCode;
  String phoneNo;
  Null latitude;
  Null longitude;
  String getCureCode;
  List<String> imageUrls;
  bool isActive;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Clinic(
      {this.id,
      this.name,
      this.type,
      this.establishmentYear,
      this.noOfBeds,
      this.noOfDoctors,
      this.state,
      this.stateId,
      this.timings,
      this.about,
      this.specialities,
      this.address,
      this.pinCode,
      this.phoneNo,
      this.latitude,
      this.longitude,
      this.getCureCode,
      this.imageUrls,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    establishmentYear = json['establishment_year'];
    noOfBeds = json['no_of_beds'];
    noOfDoctors = json['no_of_doctors'];
    state = json['state'];
    stateId = json['state_id'];
    timings = json['timings'];
    about = json['about'];
    specialities = json['specialities'].cast<String>();
    address = json['address'];
    pinCode = json['pin_code'];
    phoneNo = json['phone_no'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    getCureCode = json['get_cure_code'];
    imageUrls = json['image_urls'].cast<String>();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['establishment_year'] = this.establishmentYear;
    data['no_of_beds'] = this.noOfBeds;
    data['no_of_doctors'] = this.noOfDoctors;
    data['state'] = this.state;
    data['state_id'] = this.stateId;
    data['timings'] = this.timings;
    data['about'] = this.about;
    data['specialities'] = this.specialities;
    data['address'] = this.address;
    data['pin_code'] = this.pinCode;
    data['phone_no'] = this.phoneNo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['get_cure_code'] = this.getCureCode;
    data['image_urls'] = this.imageUrls;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
