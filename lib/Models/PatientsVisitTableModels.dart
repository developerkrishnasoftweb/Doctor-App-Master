import 'dart:convert';
import 'package:getcure_doctor/Database/AdviceTable.dart';
import 'package:moor/moor.dart';

//Brief History
class BriefHistorygenerated {
  List<BriefHistoryData> data;

  BriefHistorygenerated({this.data});

  BriefHistorygenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BriefHistoryData>();
      json['data'].forEach((v) {
        data.add(new BriefHistoryData.fromJson(v));
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

class BriefHistoryData {
  int id;
  String title;
  String date;
  String visibleTill;
  bool isCured;

  BriefHistoryData(
      {this.id, this.title, this.date, this.visibleTill, this.isCured});

  BriefHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;

    return data;
  }
}

class BriefHistoryConverter
    extends TypeConverter<BriefHistorygenerated, String> {
  const BriefHistoryConverter();

  @override
  BriefHistorygenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return BriefHistorygenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(BriefHistorygenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

// ALLERGY
class Allergy {
  List<AllergyData> data;

  Allergy({this.data});

  Allergy.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AllergyData>();
      json['data'].forEach((v) {
        data.add(new AllergyData.fromJson(v));
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

class AllergyData {
  int id;
  int clinicDoctorId;
  int doctorId;
  String title;
  String type;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isCured;

  AllergyData(
      {this.id,
      this.clinicDoctorId,
      this.doctorId,
      this.title,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isCured});

  AllergyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicDoctorId = json['clinic_doctor_id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class AllergyConverter extends TypeConverter<Allergy, String> {
  const AllergyConverter();

  @override
  Allergy mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Allergy.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Allergy value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

// LifeStyle

class LifeStyle {
  List<LifeStyleData> data;

  LifeStyle({this.data});

  LifeStyle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LifeStyleData>();
      json['data'].forEach((v) {
        data.add(new LifeStyleData.fromJson(v));
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

class LifeStyleData {
  int id;
  int clinicDoctorId;
  int doctorId;
  String title;
  String type;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isCured;

  LifeStyleData(
      {this.id,
      this.clinicDoctorId,
      this.doctorId,
      this.title,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isCured});

  LifeStyleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicDoctorId = json['clinic_doctor_id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clinic_doctor_id'] = this.clinicDoctorId;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class LifeStyleConverter extends TypeConverter<LifeStyle, String> {
  const LifeStyleConverter();

  @override
  LifeStyle mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return LifeStyle.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(LifeStyle value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

//Medication

class Medicationgenerated {
  List<MedicationData> data;

  Medicationgenerated({this.data});

  Medicationgenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MedicationData>();
      json['data'].forEach((v) {
        data.add(new MedicationData.fromJson(v));
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

class MedicationData {
  String disease;
  int symptomId;
  List<PrescribedMedicines> medicines;

  MedicationData({this.disease, this.symptomId, this.medicines});

  MedicationData.fromJson(Map<String, dynamic> json) {
    disease = json['disease'];
    symptomId = json['symptom_id'];
    if (json['medicines'] != null) {
      medicines = new List<PrescribedMedicines>();
      json['medicines'].forEach((v) {
        medicines.add(new PrescribedMedicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease'] = this.disease;
    data['symptom_id'] = this.symptomId;
    if (this.medicines != null) {
      data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrescribedMedicines {
  int medicineId;
  String title;
  String dose;
  String unit;
  String route;
  String direction;
  String frequency;
  String duration;

  PrescribedMedicines(
      {this.medicineId,
      this.title,
      this.direction,
      this.dose,
      this.duration,
      this.frequency,
      this.route,
      this.unit});

  PrescribedMedicines.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    title = json['title'];
    dose = json['dose'];
    direction = json['direction'];
    duration = json['duration'];
    frequency = json['frequency'];
    route = json['route'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_id'] = this.medicineId;
    data['title'] = this.title;
    data['dose'] = this.dose;
    data['direction'] = this.direction;
    data['duration'] = this.duration;
    data['route'] = this.route;
    data['unit'] = this.unit;
    data['frequency'] = this.frequency;

    return data;
  }
}

class MedicationConverter extends TypeConverter<Medicationgenerated, String> {
  const MedicationConverter();

  @override
  Medicationgenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Medicationgenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Medicationgenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

//examination

class Examinationgenerated {
  List<ExaminationData> data;

  Examinationgenerated({this.data});

  Examinationgenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ExaminationData>();
      json['data'].forEach((v) {
        data.add(new ExaminationData.fromJson(v));
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

class ExaminationData {
  int examinationId;
  String title;
  List<Parameters> parameters;
  String status;

  ExaminationData(
      {this.examinationId, this.title, this.parameters, this.status});

  ExaminationData.fromJson(Map<String, dynamic> json) {
    examinationId = json['examination_id'];
    title = json['title'];
    if (json['parameters'] != null) {
      parameters = new List<Parameters>();
      json['parameters'].forEach((v) {
        parameters.add(new Parameters.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examination_id'] = this.examinationId;
    data['title'] = this.title;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Parameters {
  String title;
  String type;
  List<String> references;
  String unit;
  String method;
  String sample;
  List<String> bioReference;
  List<String> result;

  Parameters(
      {this.title,
      this.type,
      this.references,
      this.method,
      this.sample,
      this.unit,
      this.bioReference,
      this.result});

  Parameters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    method = json['method'];
    sample = json['sample'];
    if (json['references'] != null) {
      references = json['references'].cast<String>();
    }
    unit = json['unit'];
    if (json['bio_reference'] != null) {
      bioReference = json['bio_reference'].cast<String>();
    }
    if (json['result'] != null) {
      result = json['result'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['references'] = this.references;
    data['unit'] = this.unit;
    data['method'] = this.method;
    data['sample'] = this.sample;
    data['bio_reference'] = this.bioReference;
    data['result'] = this.result;
    return data;
  }
}

class ExaminationConverter extends TypeConverter<Examinationgenerated, String> {
  const ExaminationConverter();

  @override
  Examinationgenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Examinationgenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Examinationgenerated value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

//Visit Reason
class VisitReasongenerated {
  List<VisitReasonData> data;

  VisitReasongenerated({this.data});

  VisitReasongenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<VisitReasonData>();
      json['data'].forEach((v) {
        data.add(new VisitReasonData.fromJson(v));
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

class VisitReasonData {
  int id;
  String title;
  String date;
  String visibleTill;
  bool isCured;

  VisitReasonData(
      {this.id, this.title, this.date, this.visibleTill, this.isCured});

  VisitReasonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class VisitReasonConverter extends TypeConverter<VisitReasongenerated, String> {
  const VisitReasonConverter();

  @override
  VisitReasongenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return VisitReasongenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(VisitReasongenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

//Dignosis
class Dignosisgenerated {
  List<DignosisData> data;

  Dignosisgenerated({this.data});

  Dignosisgenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DignosisData>();
      json['data'].forEach((v) {
        data.add(new DignosisData.fromJson(v));
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

class DignosisData {
  String title;
  String date;
  String visibleTill;
  bool isCured;

  DignosisData({this.title, this.date, this.visibleTill, this.isCured});

  DignosisData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    visibleTill = json['visible_till'];
    isCured = json['is_cured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['visible_till'] = this.visibleTill;
    data['is_cured'] = this.isCured;
    return data;
  }
}

class DignosisConverter extends TypeConverter<Dignosisgenerated, String> {
  const DignosisConverter();

  @override
  Dignosisgenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Dignosisgenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(Dignosisgenerated value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}

//Advices
class AdvicesGenerated {
  List<AdviceData> advices;

  AdvicesGenerated({this.advices});

  AdvicesGenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      advices = <AdviceData>[];
      json['data'].forEach((v) {
        advices.add(new AdviceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advices != null) {
      data['data'] = this.advices.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class AdviceData {
  String id, advice, symptoms;

  AdviceData({this.advice, this.id, this.symptoms});

  AdviceData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    advice = json['advice']?.toString();
    symptoms = json['symptoms']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advice'] = this.advice;
    data['symptoms'] = this.symptoms;
    return data;
  }
}

class AdviceConverter extends TypeConverter<AdvicesGenerated, String> {
  const AdviceConverter();

  @override
  AdvicesGenerated mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return AdvicesGenerated.fromJson(
        json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(AdvicesGenerated value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}
