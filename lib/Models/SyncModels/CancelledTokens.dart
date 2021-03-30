class CancelledTokens {
  List<CancelledTokensData> data;

  CancelledTokens({this.data});

  CancelledTokens.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CancelledTokensData>();
      json['data'].forEach((v) {
        data.add(new CancelledTokensData.fromJson(v));
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

class CancelledTokensData {
  String patientId;
  String patientName;
  String date;
  String time;
  dynamic appointmentId;
  String appointmentType;
  String visitType;
  String bookingType;
  int fees;
  String bookedAt;
  String bookedBy;
  dynamic bookedVia;
  dynamic presentTime;

  CancelledTokensData(
      {this.patientId,
      this.patientName,
      this.date,
      this.time,
      this.appointmentId,
      this.appointmentType,
      this.visitType,
      this.bookingType,
      this.fees,
      this.bookedAt,
      this.bookedBy,
      this.bookedVia,
      this.presentTime});

  CancelledTokensData.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    date = json['date'];
    time = json['time'];
    appointmentId = json['appointment_id'];
    appointmentType = json['appointment_type'];
    visitType = json['visit_type'];
    bookingType = json['booking_type'];
    fees = json['fees'];
    bookedAt = json['booked_at'];
    bookedBy = json['booked_by'];
    bookedVia = json['booked_via'];
    presentTime = json['present_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['patient_name'] = this.patientName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['appointment_id'] = this.appointmentId;
    data['appointment_type'] = this.appointmentType;
    data['visit_type'] = this.visitType;
    data['booking_type'] = this.bookingType;
    data['fees'] = this.fees;
    data['booked_at'] = this.bookedAt;
    data['booked_by'] = this.bookedBy;
    data['booked_via'] = this.bookedVia;
    data['present_time'] = this.presentTime;
    return data;
  }
}
