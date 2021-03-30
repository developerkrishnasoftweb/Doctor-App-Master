class ClinicsByState {
  List<ClinicsByStateData> data;

  ClinicsByState({this.data});

  ClinicsByState.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ClinicsByStateData>();
      json['data'].forEach((v) {
        data.add(new ClinicsByStateData.fromJson(v));
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

class ClinicsByStateData {
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
  dynamic latitude;
  dynamic longitude;
  String getCureCode;
  List<String> imageUrls;
  bool isActive;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  ClinicsByStateData(
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

  ClinicsByStateData.fromJson(Map<String, dynamic> json) {
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
