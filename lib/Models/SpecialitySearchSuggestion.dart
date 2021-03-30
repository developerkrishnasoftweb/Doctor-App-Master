class SpecialitySearch {
  List<SpecialityData> data;

  SpecialitySearch({this.data});

  SpecialitySearch.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SpecialityData>();
      json['data'].forEach((v) {
        data.add(new SpecialityData.fromJson(v));
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

class SpecialityData {
  int id;
  String title;
  bool isActive;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  SpecialityData(
      {this.id,
      this.title,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SpecialityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
