class TransaksiModel {
  String? message;
  List<DataTransaksi>? dataTransaksi;

  TransaksiModel({this.message, this.dataTransaksi});

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data_transaksi'] != null) {
      dataTransaksi = <DataTransaksi>[];
      json['data_transaksi'].forEach((v) {
        dataTransaksi!.add(new DataTransaksi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.dataTransaksi != null) {
      data['data_transaksi'] =
          this.dataTransaksi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataTransaksi {
  int? id;
  String? noRef;
  String? status;
  String? nama;
  String? deskripsi;
  String? dateIn;
  String? dateOut;
  String? timeIn;
  String? timeOut;
  String? durasi;
  String? harga;
  String? total;
  String? createdAt;
  String? updatedAt;
  Paket? paket;
  Gedung? gedung;
  Review? review;

  DataTransaksi(
      {this.id,
      this.noRef,
      this.status,
      this.nama,
      this.deskripsi,
      this.dateIn,
      this.dateOut,
      this.timeIn,
      this.timeOut,
      this.durasi,
      this.harga,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.paket,
      this.gedung,
      this.review});

  DataTransaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noRef = json['no_ref'];
    status = json['status'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    dateIn = json['date_in'];
    dateOut = json['date_out'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    durasi = json['durasi'];
    harga = json['harga'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
    gedung =
        json['gedung'] != null ? new Gedung.fromJson(json['gedung']) : null;
    review =
        json['review'] != null ? new Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_ref'] = this.noRef;
    data['status'] = this.status;
    data['nama'] = this.nama;
    data['deskripsi'] = this.deskripsi;
    data['date_in'] = this.dateIn;
    data['date_out'] = this.dateOut;
    data['time_in'] = this.timeIn;
    data['time_out'] = this.timeOut;
    data['durasi'] = this.durasi;
    data['harga'] = this.harga;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.paket != null) {
      data['paket'] = this.paket!.toJson();
    }
    if (this.gedung != null) {
      data['gedung'] = this.gedung!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    return data;
  }
}

class Paket {
  int? id;
  String? nama;
  String? deskripsi;
  String? harga;
  String? path;
  String? kapasitasRuangan;
  String? createdAt;
  String? updatedAt;

  Paket(
      {this.id,
      this.nama,
      this.deskripsi,
      this.harga,
      this.path,
      this.kapasitasRuangan,
      this.createdAt,
      this.updatedAt});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    path = json['path'];
    kapasitasRuangan = json['kapasitas_ruangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['deskripsi'] = this.deskripsi;
    data['harga'] = this.harga;
    data['path'] = this.path;
    data['kapasitas_ruangan'] = this.kapasitasRuangan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Gedung {
  int? id;
  String? nama;
  String? email;
  String? telepon;
  String? alamat;
  String? path;
  String? website;
  String? instagram;
  String? facebook;
  String? deskripsi;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Gedung({
    this.id,
    this.nama,
    this.email,
    this.telepon,
    this.alamat,
    this.path,
    this.website,
    this.instagram,
    this.facebook,
    this.deskripsi,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  Gedung.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    path = json['path'];
    website = json['website'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    deskripsi = json['deskripsi'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['path'] = this.path;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['deskripsi'] = this.deskripsi;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class Review {
  int? id;
  String? comments;
  String? starRating;
  String? createdAt;
  String? updatedAt;

  Review(
      {this.id,
      this.comments,
      this.starRating,
      this.createdAt,
      this.updatedAt});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    starRating = json['star_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['star_rating'] = this.starRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
