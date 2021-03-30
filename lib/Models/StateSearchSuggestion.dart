class StateSearch {
  List<StateData> data;

  StateSearch({this.data});

  StateSearch.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<StateData>();
      json['data'].forEach((v) {
        data.add(new StateData.fromJson(v));
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

class StateData {
  int id;
  String title;
  String slug;
  bool isActive;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  StateData(
      {this.id,
        this.title,
        this.slug,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  StateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
