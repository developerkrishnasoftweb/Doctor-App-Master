class MedicineAnalysisModel {
  List<MedicineAnalysisModelData> data;

  MedicineAnalysisModel({this.data});

  MedicineAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MedicineAnalysisModelData>();
      json['data'].forEach((v) {
        data.add(new MedicineAnalysisModelData.fromJson(v));
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

class MedicineAnalysisModelData {
  String title;
  int presCount;
  int qty;
  List<MedicineAnalysisDiseases> diseases;

  MedicineAnalysisModelData({this.title, this.presCount, this.qty, this.diseases});

  MedicineAnalysisModelData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    presCount = json['pres_count'];
    qty = json['qty'];
    if (json['diseases'] != null) {
      diseases = new List<MedicineAnalysisDiseases>();
      json['diseases'].forEach((v) {
        diseases.add(new MedicineAnalysisDiseases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pres_count'] = this.presCount;
    data['qty'] = this.qty;
    if (this.diseases != null) {
      data['diseases'] = this.diseases.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineAnalysisDiseases {
  String name;
  int count;

  MedicineAnalysisDiseases({this.name, this.count});

  MedicineAnalysisDiseases.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
