import 'dart:convert';

import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/Nutrition.dart';
import 'package:diet_penyakit/models/check.dart';
import 'package:diet_penyakit/models/pengguna.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInBloc extends ChangeNotifier {
  SignInBloc() {
    checkSignIn();
    checkGuestUser();
  }

  final GoogleSignIn _googlSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Check? check;
  Pengguna? pengguna;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  String? _name;
  String? get name => _name;

  String? _id;
  String? get id => _id;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  // String? _imageUrl;
  // String? get imageUrl => _imageUrl;

  // String? _birth;
  // String? get birth => _birth;

  String? _phone;
  String? get phone => _phone;

  String? _addres;
  String? get addres => _addres;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  void checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _isSignedIn = sp.getBool('signed_in') ?? false;
    notifyListeners();
  }

  void checkGuestUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _guestUser = sp.getBool('guest_user') ?? false;
    notifyListeners();
  }

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future<bool> checkUserExists() async {
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/check');

      http.Response response = await http.post(url!, body: {'uid': _uid});

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        check = Check.fromJson(result);
        print(check!.status!.toString());
        return check!.status!;
      } else {
        return false;
      }
    } catch (e) {
      print("error saat mengambil data $e");
      return false;
    }
  }

  // Future updateUserProfile(
  //     int newAge, int newWeight, int newHeight, String newGender) async {
  //   _age = newAge;
  //   _gender = newGender;
  //   _height = newHeight;
  //   _weight = newWeight;

  //   notifyListeners();
  // }

  // Future updateActivites(int newActivites) async {
  //   _activites = newActivites;
  //   notifyListeners();
  // }

  // Future updateGoal(int newGoal) async {
  //   _goal = newGoal;

  //   print(_goal);
  //   notifyListeners();
  // }

  Future getDataFromSp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _name = sp.getString('name');
    _email = sp.getString('email');
    _phone = sp.getString('phone');
    _addres = sp.getString('addres');
    // _imageUrl = sp.getString('image_url');
    _uid = sp.getString('uid');
    notifyListeners();
  }

  Future saveDataToSP() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // await sp.setString('id', _id!);
    await sp.setString('name', _name!);
    await sp.setString('email', _email!);
    // await sp.setString('image_url', _imageUrl!);
    await sp.setString('uid', _uid!);
    await sp.setString('phone', _phone!);
    await sp.setString('addres', _addres!);
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googlSignIn
        .signIn()
        // ignore: return_of_invalid_type_from_catch_error, avoid_print
        .catchError((error) => print('error : $error'));
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        User? userDetails =
            (await _firebaseAuth.signInWithCredential(credential)).user;
        _name = userDetails!.displayName;
        _email = userDetails.email;
        // _imageUrl = userDetails.photoURL;
        _uid = userDetails.uid;

        _hasError = false;
        notifyListeners();
      } catch (e) {
        _hasError = true;
        _errorCode = e.toString();
        notifyListeners();
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future getUserDatafromServer(uid) async {
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/view');
      http.Response response = await http.post(url!, body: {'uid': uid});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        pengguna = Pengguna.fromJson(result);
        _id = pengguna?.data?.id.toString();
        _name = pengguna?.data?.name;
        _email = pengguna?.data?.email;
        // _imageUrl = pengguna?.data?.imageUrl;
        _uid = pengguna?.data?.uid;
        _phone = pengguna?.data?.phone;
        _addres = pengguna?.data?.addres;
      }
    } catch (e) {
      print("error saat mengambil data $e");
    }
    notifyListeners();
  }

  Future<bool> saveUserData(
    String name,
    String phone,
    String addres,
  ) async {
    _name = name;
    _phone = phone;
    _addres = addres;

    notifyListeners();

    // print('$_uid $_email $_name $_age $_activites $_goal $_disease');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/register');

      http.Response response = await http.post(url!, body: {
        'uid': _uid,
        'name': _name,
        'email': _email,
        // 'image_url': _imageUrl,
        'phone': _phone,
        'addres': _addres,
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

  Future<bool> updateUserData(
    String name,
    String phone,
    String addres,
  ) async {
    // print('$_uid $_email $_name $_age $_activites $_goal $_disease');
    try {
      var url = Uri.tryParse(Config().webAdrres + 'api/register');

      http.Response response = await http.post(url!, body: {
        'uid': _uid,
        'name': name,
        'email': _email,
        // 'image_url': _imageUrl,
        'phone': phone,
        'addres': addres,
      });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("error saat mengambil data " + result.toString());
        // check = Check.fromJson(result);

        _name = name;
        _phone = phone;
        _addres = addres;

        notifyListeners();

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

  // Future updateNutrition() async {
  //   _nutrition =
  //       Nutrition(_gender!, _height!, _weight!, _age!, _activites!, _goal!);
  //   notifyListeners();
  // }

  Future clearAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future userSignout() async {
    await _firebaseAuth.signOut();
    await _googlSignIn.signOut();

    await clearAllData();
    _isSignedIn = false;
    notifyListeners();
  }
}
