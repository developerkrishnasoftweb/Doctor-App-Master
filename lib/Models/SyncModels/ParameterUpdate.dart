class ParametersUpdate {
  ParameterUpdateData data;

  ParametersUpdate({this.data});

  ParametersUpdate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ParameterUpdateData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ParameterUpdateData {
  List<ParameterData> category;
  List<ParameterData> dose;
  List<ParameterData> unit;
  List<ParameterData> route;
  List<ParameterData> frequency;
  List<ParameterData> direction;
  List<ParameterData> duration;

  ParameterUpdateData(
      {this.category,
      this.dose,
      this.unit,
      this.route,
      this.frequency,
      this.direction,
      this.duration});

  ParameterUpdateData.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = new List<ParameterData>();
      json['category'].forEach((v) {
        category.add(new ParameterData.fromJson(v));
      });
    }
    if (json['dose'] != null) {
      dose = new List<ParameterData>();
      json['dose'].forEach((v) {
        dose.add(new ParameterData.fromJson(v));
      });
    }
    if (json['unit'] != null) {
      unit = new List<ParameterData>();
      json['unit'].forEach((v) {
        unit.add(new ParameterData.fromJson(v));
      });
    }
    if (json['route'] != null) {
      route = new List<ParameterData>();
      json['route'].forEach((v) {
        route.add(new ParameterData.fromJson(v));
      });
    }
    if (json['frequency'] != null) {
      frequency = new List<ParameterData>();
      json['frequency'].forEach((v) {
        frequency.add(new ParameterData.fromJson(v));
      });
    }
    if (json['direction'] != null) {
      direction = new List<ParameterData>();
      json['direction'].forEach((v) {
        direction.add(new ParameterData.fromJson(v));
      });
    }
    if (json['duration'] != null) {
      duration = new List<ParameterData>();
      json['duration'].forEach((v) {
        duration.add(new ParameterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.dose != null) {
      data['dose'] = this.dose.map((v) => v.toJson()).toList();
    }
    if (this.unit != null) {
      data['unit'] = this.unit.map((v) => v.toJson()).toList();
    }
    if (this.route != null) {
      data['route'] = this.route.map((v) => v.toJson()).toList();
    }
    if (this.frequency != null) {
      data['frequency'] = this.frequency.map((v) => v.toJson()).toList();
    }
    if (this.direction != null) {
      data['direction'] = this.direction.map((v) => v.toJson()).toList();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParameterData {
  String title;
  int value;
  String type;
  bool isOnline;
  ParameterData({
    this.title,
    this.value,
    this.type,
    this.isOnline
  });

  ParameterData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    type = json['type'];
    isOnline=json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['type'] = this.type;
    data['isOnline'] = this.isOnline;
    return data;
  }
}


class ParameterSync {
  List<Params> params;

  ParameterSync({this.params});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.params != null) {
      data['params'] = this.params.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Params {
  String type;
  String name;
  int value;

  Params({this.type, this.name, this.value});

  Params.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
