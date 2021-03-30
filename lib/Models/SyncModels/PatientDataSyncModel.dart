class PatientDataSync {
  List<PatientDataSyncData> data;

  PatientDataSync({this.data});

  PatientDataSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PatientDataSyncData>();
      json['data'].forEach((v) {
        data.add(new PatientDataSyncData.fromJson(v));
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

class PatientDataSyncData {
  String name;
  String patientId;
  String mobileNo;
  int age;
  String gender;
  String address;
  String createdAt;
  String updatedAt;

  PatientDataSyncData(
      {this.name,
      this.patientId,
      this.mobileNo,
      this.age,
      this.gender,
      this.address,
      this.createdAt,
      this.updatedAt});

  PatientDataSyncData.fromJson(Map<String, dynamic> json) {
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
