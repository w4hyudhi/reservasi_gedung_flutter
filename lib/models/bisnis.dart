class Bisnis {
  String? message;
  List<DataBisnis>? dataBisnis;

  Bisnis({this.message, this.dataBisnis});

  Bisnis.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data_bisnis'] != null) {
      dataBisnis = <DataBisnis>[];
      json['data_bisnis'].forEach((v) {
        dataBisnis!.add(new DataBisnis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.dataBisnis != null) {
      data['data_bisnis'] = this.dataBisnis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBisnis {
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
  List<Paket>? paket;

  DataBisnis(
      {this.id,
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
      this.paket});

  DataBisnis.fromJson(Map<String, dynamic> json) {
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
    if (json['paket'] != null) {
      paket = <Paket>[];
      json['paket'].forEach((v) {
        paket!.add(new Paket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    if (this.paket != null) {
      data['paket'] = this.paket!.map((v) => v.toJson()).toList();
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
  List<Booking>? booking;
  List<Galeri>? galeri;
  List<Review>? review;

  Paket(
      {this.id,
      this.nama,
      this.deskripsi,
      this.harga,
      this.path,
      this.kapasitasRuangan,
      this.createdAt,
      this.updatedAt,
      this.booking,
      this.galeri,
      this.review});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    path = json['path'];
    kapasitasRuangan = json['kapasitas_ruangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
    if (json['galeri'] != null) {
      galeri = <Galeri>[];
      json['galeri'].forEach((v) {
        galeri!.add(new Galeri.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
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
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    if (this.galeri != null) {
      data['galeri'] = this.galeri!.map((v) => v.toJson()).toList();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
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

  Booking(
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
      this.updatedAt});

  Booking.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Galeri {
  int? id;
  String? nama;
  String? path;
  String? deskripsi;
  String? createdAt;
  String? updatedAt;

  Galeri(
      {this.id,
      this.nama,
      this.path,
      this.deskripsi,
      this.createdAt,
      this.updatedAt});

  Galeri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    path = json['path'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['path'] = this.path;
    data['deskripsi'] = this.deskripsi;
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
  Pengguna? pengguna;

  Review(
      {this.id,
      this.comments,
      this.starRating,
      this.createdAt,
      this.updatedAt,
      this.pengguna});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    comments = json['comments'];
    starRating = json['star_rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pengguna = json['pengguna'] != null
        ? new Pengguna.fromJson(json['pengguna'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['star_rating'] = this.starRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pengguna != null) {
      data['pengguna'] = this.pengguna!.toJson();
    }
    return data;
  }
}

class Pengguna {
  int? id;
  String? uid;
  String? name;
  String? phone;
  String? email;
  Null? image;
  Null? emailVerifiedAt;
  Null? password;
  Null? cmFirebaseToken;
  String? address;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  Pengguna(
      {this.id,
      this.uid,
      this.name,
      this.phone,
      this.email,
      this.image,
      this.emailVerifiedAt,
      this.password,
      this.cmFirebaseToken,
      this.address,
      this.rememberToken,
      this.createdAt,
      this.updatedAt});

  Pengguna.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    cmFirebaseToken = json['cm_firebase_token'];
    address = json['address'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['address'] = this.address;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
