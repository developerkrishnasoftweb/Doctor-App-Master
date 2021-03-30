class DoctorInvoiceModel {
  List<DocData> data;

  DoctorInvoiceModel({this.data});

  DoctorInvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DocData>();
      json['data'].forEach((v) {
        data.add(new DocData.fromJson(v));
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

class DocData {
  String date;
  int emergencies;
  int newVisits;
  int followUps;
  int totalAppointments;
  int feesCollected;
  int onCall;

  DocData(
      {this.date,
      this.emergencies,
      this.newVisits,
      this.followUps,
      this.totalAppointments,
      this.feesCollected,
      this.onCall});

  DocData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    emergencies = json['emergencies'];
    newVisits = json['new_visits'];
    followUps = json['follow_ups'];
    totalAppointments = json['total_appointments'];
    feesCollected = json['fees_collected'];
    onCall = json['on_call'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['emergencies'] = this.emergencies;
    data['new_visits'] = this.newVisits;
    data['follow_ups'] = this.followUps;
    data['total_appointments'] = this.totalAppointments;
    data['fees_collected'] = this.feesCollected;
    data['on_call'] = this.onCall;
    return data;
  }
}