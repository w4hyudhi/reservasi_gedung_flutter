import 'dart:convert';

import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SearchBloc with ChangeNotifier {
  SearchBloc() {
    getRecentSearchList();
  }

  List<String> _recentSearchData = [];
  List<String> get recentSearchData => _recentSearchData;

  String _searchText = '';
  String get searchText => _searchText;

  bool _searchStarted = false;
  bool get searchStarted => _searchStarted;

  TextEditingController _textFieldCtrl = TextEditingController();
  TextEditingController get textfieldCtrl => _textFieldCtrl;

  Future getRecentSearchList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData = sp.getStringList('recent_search_data') ?? [];
    notifyListeners();
  }

  Future addToSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.add(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }

  Future removeFromSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.remove(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }

  Future<List> getData() async {
    List<DataBisnis> data = [];

    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/resep/index');
      http.Response response = await http.get(url!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Bisnis _resep = Bisnis.fromJson(result);
        // data = _resep.dataResep!.toList();

        List<DataBisnis> _snap = [];
        _snap.addAll(_resep.dataBisnis!.where((u) =>
            (u.nama!.toLowerCase().contains(_searchText.toLowerCase()))));
        data = _snap.toList();

        print("berhasil");
      } else {
        print("gagal");
      }
    } catch (e) {
      print("gagal");
    }
    return data;
  }

  setSearchText(value) {
    _textFieldCtrl.text = value;
    _searchText = value;
    _searchStarted = true;
    notifyListeners();
  }

  saerchInitialize() {
    _textFieldCtrl.clear();
    _searchStarted = false;
    notifyListeners();
  }
}
