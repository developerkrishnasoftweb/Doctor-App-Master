import 'PatientsVisitTableModels.dart';

class SuggestionsModel {
  int id;
  int doctorId;
  String title;
  String gender;
  String ageGroup;
  String weightGroup;
  List<ExaminationData> examination;
  List diagnosis;
  List<PrescribedMedicines> medications;

  SuggestionsModel(
      {this.id,
      this.doctorId,
      this.title,
      this.gender,
      this.ageGroup,
      this.weightGroup,
      this.examination,
      this.diagnosis,
      this.medications});

  SuggestionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    gender = json['gender'];
    ageGroup = json['age_group'];
    weightGroup = json['weight_group'];
    if (json['examination'] != null) {
      examination = <ExaminationData>[];
      json['examination'].forEach((v) {
        print(v['examination']);
        examination.add(new ExaminationData.fromJson(v['examination']));
      });
    }
    if (json['diagonis'] != null) {
      diagnosis = json['diagonis'];
    }
    if (json['medications'] != null) {
      medications = <PrescribedMedicines>[];
      json['medications'].forEach((v) {
        medications.add(new PrescribedMedicines.fromJson(v)
          ..title = v['medicine']['title']);
      });
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['doctor_id'] = this.doctorId;
//   data['title'] = this.title;
//   data['gender'] = this.gender;
//   data['age_group'] = this.ageGroup;
//   data['weight_group'] = this.weightGroup;
//   if (this.examination != null) {
//     data['examination'] = this.examination.map((v) => v.toJson()).toList();
//   }
//   if (this.diagnosis != null) {
//     data['diagonis'] = this.diagnosis.map((v) => v.toJson()).toList();
//   }
//   if (this.medications != null) {
//     data['medications'] = this.medications.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
