class SyncCancelledTokens {
  List<CancelledTokens> tokens;

  SyncCancelledTokens({this.tokens});

  SyncCancelledTokens.fromJson(Map<String, dynamic> json) {
    if (json['tokens'] != null) {
      tokens = new List<CancelledTokens>();
      json['tokens'].forEach((v) {
        tokens.add(new CancelledTokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokens != null) {
      data['tokens'] = this.tokens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CancelledTokens {
  String patientId;
  String patientName;
  String date;
  String time;
  String appointmentType;
  String visitType;

  CancelledTokens(
      {this.patientId,
      this.patientName,
      this.date,
      this.time,
      this.appointmentType,
      this.visitType});

  CancelledTokens.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    date = json['date'];
    time = json['time'];
    appointmentType = json['appointment_type'];
    visitType = json['visit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['appointment_type'] = this.appointmentType;
    data['visit_type'] = this.visitType;
    return data;
  }
}
