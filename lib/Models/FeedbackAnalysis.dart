class FeedbackAnalysis {
  List<FeedBackAnalysisData> data;

  FeedbackAnalysis({this.data});

  FeedbackAnalysis.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FeedBackAnalysisData>();
      json['data'].forEach((v) {
        data.add(new FeedBackAnalysisData.fromJson(v));
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

class FeedBackAnalysisData {
  String question;
  List<Options> options;

  FeedBackAnalysisData({this.question, this.options});

  FeedBackAnalysisData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String title;
  dynamic count;

  Options({this.title, this.count});

  Options.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    count = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['count'] = this.count;
    return data;
  }
}
