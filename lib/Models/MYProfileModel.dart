import 'package:getcure_doctor/Models/DoctorLogin.dart';

class MyDoctorProfile {
  DoctorLoginData data;

  MyDoctorProfile({this.data});

  MyDoctorProfile.fromJson(Map<String, dynamic> json) {
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

