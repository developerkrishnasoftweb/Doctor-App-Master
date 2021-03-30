import 'package:getcure_doctor/Models/DoctorLogin.dart';

class SendTime {
  List<TimingGenerationValue> doctorTimings;

  SendTime({this.doctorTimings});

  SendTime.fromJson(Map<String, dynamic> json) {
    if (json['doctor_timings'] != null) {
      doctorTimings = new List<TimingGenerationValue>();
      json['doctor_timings'].forEach((v) {
        doctorTimings.add(new TimingGenerationValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorTimings != null) {
      data['doctor_timings'] =
          this.doctorTimings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimingGenerationValue {
  String day;
  List<Slots> slots;

  TimingGenerationValue({this.day, this.slots});

  TimingGenerationValue.fromJson(Map<String, dynamic> json) {
    day=json['day'];
    if (json['slots'] != null) {
      slots = new List<Slots>();
      json['slots'].forEach((v) {
        slots.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day']=this.day;
    if (this.slots != null) {
      data['slots']=this.slots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class SlotsDoctor {
//   String startTime;
//   String endTime;
//   int noOfPatients;

//   SlotsDoctor({this.startTime, this.endTime, this.noOfPatients});

//   SlotsDoctor.fromJson(Map<String, dynamic> json) {
//     startTime=json['start_time'];
//     endTime=json['end_time'];
//     noOfPatients=json['no_of_patients'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['start_time']=this.startTime;
//     data['end_time']=this.endTime;
//     data['no_of_patients']=this.noOfPatients;
//     return data;
//   }

//   String toString(){
//     return startTime + " - " + endTime + " - " + noOfPatients.toString(); 
//   }
// }
