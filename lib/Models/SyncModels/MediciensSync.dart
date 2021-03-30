class MedicineDataSync {
  List<MedicinesSync> medicines;

  MedicineDataSync({this.medicines});

  MedicineDataSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      medicines = new List<MedicinesSync>();
      json['data'].forEach((v) {
        medicines.add(new MedicinesSync.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicines != null) {
      data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicinesSync {
  int doctorId;
  String title;
  String salt;
  List<String> interactionDrugs;
  String category;
  String defaultDose;
  String defaultUnit;
  String defaultRoute;
  String defaultFrequency;
  String defaultDirection;
  String defaultDuration;

  MedicinesSync(
      {this.doctorId,
      this.title,
      this.salt,
      this.interactionDrugs,
      this.category,
      this.defaultDose,
      this.defaultUnit,
      this.defaultRoute,
      this.defaultFrequency,
      this.defaultDirection,
      this.defaultDuration});

  MedicinesSync.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    title = json['title'];
    salt = json['salt'];
    interactionDrugs = json['interaction_drugs'].cast<String>();
    category = json['category'];
    defaultDose = json['default_dose'];
    defaultUnit = json['default_unit'];
    defaultRoute = json['default_route'];
    defaultFrequency = json['default_frequency'];
    defaultDirection = json['default_direction'];
    defaultDuration = json['default_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['salt'] = this.salt;
    data['interaction_drugs'] = this.interactionDrugs;
    data['category'] = this.category;
    data['default_dose'] = this.defaultDose;
    data['default_unit'] = this.defaultUnit;
    data['default_route'] = this.defaultRoute;
    data['default_frequency'] = this.defaultFrequency;
    data['default_direction'] = this.defaultDirection;
    data['default_duration'] = this.defaultDuration;
    return data;
  }
}
