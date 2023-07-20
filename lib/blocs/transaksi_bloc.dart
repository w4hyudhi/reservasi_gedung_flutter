import 'dart:convert';

import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/sawah_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaksi_model.dart';

class TransaksiBloc extends ChangeNotifier {
  TransaksiModel? _order;
  TransaksiModel? get order => _order;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasData = false;
  bool get hasData => _hasData;

  Future getData() async {
    _hasData = true;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? uid = sp.getString('uid');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/booking/get');
      http.Response response = await http.post(url!, body: {'uid': uid});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        _order = TransaksiModel.fromJson(result);

        _isLoading = false;
        _hasData = true;
        print("berhasil" + _order.toString());
      } else {
        _isLoading = false;
        _hasData = false;
        print("gagal");
      }
    } catch (e) {
      _isLoading = false;
      _hasData = false;
      print("error saat mengambil data $e");
    }
    notifyListeners();
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  Future<bool> saveTransaksi(
    String paket_id,
    String nama,
    String deskripsi,
    String date_in,
    String date_out,
    String time_in,
    String time_out,
    String durasi,
    String harga,
    String total,
  ) async {
    // String? _sawah_id = sawah_id;
    // String? _tanggal = tanggal;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? uid = sp.getString('uid');
    notifyListeners();

    // print("error saat mengambil data $e");
    print(
        '$paket_id, $nama, $deskripsi, $date_in, $date_out, $time_in, $time_out, $durasi, $harga, $total ');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/booking/add');

      http.Response response = await http.post(url!, body: {
        'uid': uid,
        "paket_id": paket_id,
        "nama": nama,
        "deskripsi": deskripsi,
        "date_in": date_in,
        "date_out": date_out,
        "time_in": time_in,
        "time_out": time_out,
        "durasi": durasi,
        "harga": harga,
        "total": total,
      });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("error saat mengambil data " + result.toString());
        // check = Check.fromJson(result);
        return true;
      } else {
        print("error simpan ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("error saat mengambil data $e");
      return false;
    }
  }

  Future<bool> saveRating(
    String booking_id,
    String ratting,
    String comments,
  ) async {
    notifyListeners();

    print("error saat mengambil data $booking_id, $ratting, $comments");
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/booking/ratting');

      http.Response response = await http.post(url!, body: {
        'booking_id': booking_id,
        "ratting": ratting,
        "comments": comments,
      });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("error saat mengambil data " + result.toString());
        // check = Check.fromJson(result);
        return true;
      } else {
        print("error simpan ${response.body}");
        return false;
      }
    } catch (e) {
      print("error saat mengambil data $e");
      return false;
    }
  }
}
