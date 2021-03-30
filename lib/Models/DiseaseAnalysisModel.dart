class DiseaseAnalysisModel {
  List<DiseaseAnalysisModelData> data;

  DiseaseAnalysisModel({this.data});

  DiseaseAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DiseaseAnalysisModelData>();
      json['data'].forEach((v) {
        data.add(new DiseaseAnalysisModelData.fromJson(v));
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

class DiseaseAnalysisModelData {
  String name;
  int total;
  int feedback;
  int cured;
  int partial;
  int notCured;
  int symptomsIncreased;
  List<DiseaseAnalysisMedicines> medicines;
  int quality;

  DiseaseAnalysisModelData(
      {this.name,
      this.total,
      this.feedback,
      this.cured,
      this.partial,
      this.notCured,
      this.symptomsIncreased,
      this.medicines,
      this.quality});

  DiseaseAnalysisModelData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    total = json['total'];
    feedback = json['feedback'];
    cured = json['cured'];
    partial = json['partial'];
    notCured = json['not_cured'];
    symptomsIncreased = json['symptoms_increased'];
    if (json['medicines'] != null) {
      medicines = new List<DiseaseAnalysisMedicines>();
      json['medicines'].forEach((v) {
        medicines.add(new DiseaseAnalysisMedicines.fromJson(v));
      });
    }
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total'] = this.total;
    data['feedback'] = this.feedback;
    data['cured'] = this.cured;
    data['partial'] = this.partial;
    data['not_cured'] = this.notCured;
    data['symptoms_increased'] = this.symptomsIncreased;
    if (this.medicines != null) {
      data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
    }
    data['quality'] = this.quality;
    return data;
  }
}

class DiseaseAnalysisMedicines {
  String title;
  int count;

  DiseaseAnalysisMedicines({this.title, this.count});

  DiseaseAnalysisMedicines.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['count'] = this.count;
    return data;
  }
}
