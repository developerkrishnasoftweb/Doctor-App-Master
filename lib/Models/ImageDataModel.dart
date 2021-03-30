class ImageDataModel {
  String data;

  ImageDataModel({this.data});

  ImageDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}

class SendImageDataModel {
  List<IdentityVerificationUrl> identityVerificationUrl;

  SendImageDataModel({this.identityVerificationUrl});

  SendImageDataModel.fromJson(Map<String, dynamic> json) {
    if (json['identity_verification_url'] != null) {
      identityVerificationUrl = new List<IdentityVerificationUrl>();
      json['identity_verification_url'].forEach((v) {
        identityVerificationUrl.add(new IdentityVerificationUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identityVerificationUrl != null) {
      data['identity_verification_url'] =
          this.identityVerificationUrl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdentityVerificationUrl {
  String type;
  String url;

  IdentityVerificationUrl({this.type, this.url});

  IdentityVerificationUrl.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}