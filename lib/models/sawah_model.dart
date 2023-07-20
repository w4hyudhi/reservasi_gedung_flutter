class SawahModel {
  String? message;
  List<DataSawah>? dataSawah;

  SawahModel({this.message, this.dataSawah});

  SawahModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data_sawah'] != null) {
      dataSawah = <DataSawah>[];
      json['data_sawah'].forEach((v) {
        dataSawah!.add(new DataSawah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.dataSawah != null) {
      data['data_sawah'] = this.dataSawah!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSawah {
  int? id;
  String? userId;
  String? name;
  String? addres;
  String? luas;
  String? latitude;
  String? longitude;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  DataSawah(
      {this.id,
      this.userId,
      this.name,
      this.addres,
      this.luas,
      this.latitude,
      this.longitude,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  DataSawah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    addres = json['addres'];
    luas = json['luas'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['addres'] = this.addres;
    data['luas'] = this.luas;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
