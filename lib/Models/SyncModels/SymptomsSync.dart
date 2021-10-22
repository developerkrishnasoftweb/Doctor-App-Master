class SymptomSync {
  List<SymptomDataSync> symptoms;

  SymptomSync({this.symptoms});

  SymptomSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      symptoms = new List<SymptomDataSync>();
      json['data'].forEach((v) {
        symptoms.add(new SymptomDataSync.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.symptoms != null) {
      data['symptoms'] = this.symptoms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SymptomDataSync {
  int id;
  int doctorId;
  String title;
  String visibilityPeriod;

  SymptomDataSync({this.doctorId, this.title, this.visibilityPeriod});

  SymptomDataSync.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    visibilityPeriod = json['visibility_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['visibility_period'] = this.visibilityPeriod;
    return data;
  }
}
