class TokenSync{

  List<TokenSyncData> data;

  TokenSync({
    this.data
  });
  
  TokenSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TokenSyncData>();
      json['data'].forEach((v) {
        data.add(new TokenSyncData.fromJson(v));
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

class TokenSyncData{

  String appointmentId;
  String patientId;
  String patientName;
  String appointmentType;
  String visitType;
  String bookingType;
  String date;
  String time;
  int fees;
  int tokenNo;
  int clinicDoctorId;
  bool isPresent;
  String bookedAt;
  String bookedBy;
  String bookedVia;
  String presentTime;

  TokenSyncData({
    this.appointmentId,
    this.patientId,
    this.patientName,
    this.appointmentType,
    this.visitType,
    this.bookingType,
    this.date,
    this.time,
    this.fees,
    this.tokenNo,
    this.clinicDoctorId,
    this.isPresent,
    this.bookedAt,
    this.bookedBy,
    this.bookedVia,
    this.presentTime
  });

  TokenSyncData.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    appointmentType= json['appointment_type'];
    visitType = json['visit_type'];
    bookingType = json['booking_type'];
    date = json['date'];
    time = json['time'];
    fees = json['fees'];
    tokenNo = json['token_no'];
    clinicDoctorId = json['clinic_doctor_id'];
    isPresent = json['is_present'];
    bookedAt = json['booked_at'];
    bookedBy= json['booked_by'];
    bookedVia = json['booked_via'];
    presentTime = json['present_time'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['patient_id'] = this.patientId;
    data['patient_name']= this.patientName;
    data['appointment_type']= this.appointmentType;
    data['visit_type']= this.visitType;
    data['booking_type']=this.bookingType;
    data['date']=this.date;
    data['time']=this.time;
    data['fees']=this.fees;
    data['token_no']=this.tokenNo;
    data['clinic_doctor_id']=clinicDoctorId;
    data['is_present']=this.isPresent;
    data['booked_at']=this.bookedAt;
    data['booked_by'] = this.bookedBy;
    data['booked_via'] = this.bookedVia;
    data['present_time']= this.presentTime;
    return data;
  }
}

/*

 patient_id?: string;
  patient_name?: string;
  appointment_type: AppointmentTypes;
  visit_type: VisitType;
  booking_type: BookingType;
  date: string;
  time: string;
  fees: number;
  token_no: number | string;
  clinic_doctor_id: number;
  is_present?: boolean;
  booked_at?: Date;

*/
