class Pengguna {
  String? message;
  Data? data;

  Pengguna({this.message, this.data});

  Pengguna.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uid;
  String? name;
  String? email;
  String? imageUrl;
  String? phone;
  String? addres;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.phone,
      this.addres,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['image_url'];
    phone = json['phone'];
    addres = json['address'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    data['phone'] = this.phone;
    data['addres'] = this.addres;

    return data;
  }
}
