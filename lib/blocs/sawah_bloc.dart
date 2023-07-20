import 'dart:convert';

import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/sawah_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SawahBloc extends ChangeNotifier {
  SawahModel? _sawah;
  SawahModel? get datasawah => _sawah;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasData = false;
  bool get hasData => _hasData;

  Future getData() async {
    _hasData = true;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? uid = sp.getString('uid');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/sawah/get');
      http.Response response = await http.post(url!, body: {'uid': uid});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        _sawah = SawahModel.fromJson(result);

        _isLoading = false;
        _hasData = true;
        print("berhasil" + _sawah.toString());
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

  Future<bool> saveSawah(
    String name,
    String addres,
    String luas,
    String lattitude,
    String longitude,
  ) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    String? _name = name;
    String? _addres = addres;
    String? _luas = luas;
    String? _latitude = lattitude;
    String? _longitude = longitude;

    notifyListeners();
    // print("error saat mengambil data $e");
    print('$_uid $_name $_addres $_luas $_latitude $_longitude');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/sawah/add');

      http.Response response = await http.post(url!, body: {
        'uid': _uid,
        'name': _name,
        'addres': _addres,
        'luas': _luas,
        'latitude': _latitude,
        'longitude': _longitude,
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
}
