import 'package:getcure_doctor/Database/ExaminationTable.dart';

class ExaminationSync {
  List<ExaminationsDataSync> examinations;

  ExaminationSync({this.examinations});

  ExaminationSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      examinations = new List<ExaminationsDataSync>();
      json['data'].forEach((v) {
        examinations.add(new ExaminationsDataSync.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.examinations != null) {
      data['examinations'] = this.examinations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExaminationsDataSync {
  int doctorId;
  String title;
  List<ParameterData> parameters;

  ExaminationsDataSync({this.doctorId, this.title, this.parameters});

  ExaminationsDataSync.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    title = json['title'];
    if (json['parameters'] != null) {
      parameters = new List<ParameterData>();
      json['parameters'].forEach((v) {
        parameters.add(new ParameterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SyncParameters {
  String title;
  String sample;
  String method;
  String type;
  List<String> references;
  String unit;
  List<String> bioReferences;

  SyncParameters(
      {this.title,
      this.sample,
      this.method,
      this.type,
      this.references,
      this.unit,
      this.bioReferences});

  SyncParameters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sample = json['sample'];
    method = json['method'];
    type = json['type'];
    references = json['references'].cast<String>();
    unit = json['unit'];
    bioReferences = json['bio_references'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sample'] = this.sample;
    data['method'] = this.method;
    data['type'] = this.type;
    data['references'] = this.references;
    data['unit'] = this.unit;
    data['bio_references'] = this.bioReferences;
    return data;
  }
}
