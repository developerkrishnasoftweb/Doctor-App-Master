import 'package:getcure_doctor/Database/ExaminationTable.dart';

class SyncExam {
  List<SyncExamData> data;
   
  SyncExam({this.data});

  SyncExam.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SyncExamData>();
      json['data'].forEach((v) {
        data.add(new SyncExamData.fromJson(v));
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

class SyncExamData {
  int id;
  int doctorId;
  String title;
  List<ParameterData> parameters;
  int price;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  SyncExamData(
      {this.id,
      this.doctorId,
      this.title,
      this.parameters,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SyncExamData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    if (json['parameters'] != null) {
      parameters = new List<ParameterData>();
      json['parameters'].forEach((v) {
        parameters.add(new ParameterData.fromJson(v));
      });
    }
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Parameters {
  String title;
  String sample;
  String method;
  String type;
  List<String> references;
  String unit;
  List<String> bioReferences;

  Parameters(
      {this.title,
      this.sample,
      this.method,
      this.type,
      this.references,
      this.unit,
      this.bioReferences});

  Parameters.fromJson(Map<String, dynamic> json) {
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
