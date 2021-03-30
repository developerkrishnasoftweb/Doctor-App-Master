class GuidUpdating {
  List<PatientIds> patientIds;

  GuidUpdating({this.patientIds});

  GuidUpdating.fromJson(Map<String, dynamic> json) {
    if (json['patient_ids'] != null) {
      patientIds = new List<PatientIds>();
      json['patient_ids'].forEach((v) {
        patientIds.add(new PatientIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientIds != null) {
      data['patient_ids'] = this.patientIds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientIds {
  String previousId;
  String newId;

  PatientIds({this.previousId, this.newId});

  PatientIds.fromJson(Map<String, dynamic> json) {
    previousId = json['previousId'];
    newId = json['newId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previousId'] = this.previousId;
    data['newId'] = this.newId;
    return data;
  }
}
