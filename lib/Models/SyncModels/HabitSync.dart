class HabitsSync {
  List<HabitsSyncData> habits;

  HabitsSync({this.habits});

  HabitsSync.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      habits = new List<HabitsSyncData>();
      json['data'].forEach((v) {
        habits.add(new HabitsSyncData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.habits != null) {
      data['habits'] = this.habits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HabitsSyncData {
  int id;
  int doctorId;
  String title;
  String type;

  HabitsSyncData({this.doctorId, this.title, this.type, this.id});

  HabitsSyncData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
