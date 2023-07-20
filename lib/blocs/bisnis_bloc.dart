import 'dart:convert';

import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BisnisBloc extends ChangeNotifier {
  Bisnis? _bisnis;
  Bisnis? get data => _bisnis;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasData = true;
  bool get hasData => _hasData;

  // Resep? _resep1;
  // Resep? get data1 => _resep1;

  // List<DataResep> _data = [];
  // List<DataResep> get data => _data;

  Future getData() async {
    _hasData = true;
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/product/get');
      http.Response response = await http.get(url!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        _bisnis = Bisnis.fromJson(result);
        // String nama =_resep.dataResep
        // _data = jsonDecode(response.body);
        if (_bisnis!.dataBisnis!.isEmpty) {
          _isLoading = false;
          _hasData = false;
          print("gagal");
        } else {
          print("berhasil");
          _isLoading = false;
          _hasData = true;
        }
        print("berhasil");
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

  // Future getSuggest() async {
  //   _hasData = true;
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   try {
  //     var url = Uri.tryParse(Config().webAdrres + 'api/resep/suggest');
  //     http.Response response =
  //         await http.post(url!, body: {'penyakit': penyakit});
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       _resep = Resep.fromJson(result);
  //       if (_resep!.dataResep!.isEmpty) {
  //         _isLoading = false;
  //         _hasData = false;
  //         print("gagal");
  //       } else {
  //         print("berhasil");
  //         _isLoading = false;
  //         _hasData = true;
  //       }
  //       print("berhasil");
  //     } else {
  //       _isLoading = false;
  //       _hasData = false;
  //       print("gagal");
  //     }
  //   } catch (e) {
  //     _isLoading = false;
  //     _hasData = false;
  //     print("error saat mengambil data $e");
  //   }
  //   notifyListeners();
  // }

  // Future getCategory(String penyakit) async {
  //   _isLoading = true;
  //   _hasData = true;
  //   print(penyakit);
  //   try {
  //     var url = Uri.tryParse(Config().webAdrres + 'api/resep/suggest');
  //     http.Response response =
  //         await http.post(url!, body: {'penyakit': penyakit});
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       _resep = Resep.fromJson(result);

  //       if (_resep!.dataResep!.isEmpty) {
  //         _isLoading = false;
  //         _hasData = false;
  //         print("gagal 1");
  //       } else {
  //         print("berhasil");
  //         _isLoading = false;
  //         _hasData = true;
  //       }
  //     } else {
  //       _isLoading = false;
  //       _hasData = false;
  //       print("gagal 2");
  //     }
  //     print(_resep);
  //   } catch (e) {
  //     _isLoading = false;
  //     _hasData = false;
  //     print("error saat mengambil data $e");
  //   }
  //   notifyListeners();
  // }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onReload(String penyakit) {
    _isLoading = true;
    _bisnis?.dataBisnis?.clear();
    notifyListeners();
  }

  // setPenyakit(bool isData) {
  //   _hasPenyakit = isData;
  //   notifyListeners();
  // }
}
