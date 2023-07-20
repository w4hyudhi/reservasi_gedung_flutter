import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:diet_penyakit/blocs/internet_bloc.dart';
import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
import 'package:diet_penyakit/pages/home_page.dart';
import 'package:diet_penyakit/utils/next_screen.dart';

import '../configs/Colors.dart';

class RegisterProfilePage extends StatefulWidget {
  RegisterProfilePage({Key? key}) : super(key: key);

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phoneNumber;
  String? _address;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  String error4 = '';

  handleUpdateData() async {
    final sb = context.read<SignInBloc>();
    final ib = context.read<InternetBloc>();
    setState(() => loading = true);
    await ib.checkInternet();
    if (ib.checkInternet() == false) {
      setState(() {
        loading = false;
        error4 = 'Koneksi internet bermasalah';
      });
      // openSnacbar(scaffoldKey, 'check your internet connection!');
    } else {
      sb.saveUserData(_name!, _phoneNumber!, _address!).then((value) {
        if (value != true) {
          openSnacbar(context, 'something is wrong. please try again.');
          setState(() {
            loading = false;
            error4 = 'Gagal menyimpan data';
          });
        } else {
          sb.saveDataToSP().then((value) => sb.setSignIn().then((value) {
                // openSnacbar(scaffoldKey, 'Pendaftaran Berhasil.');
                setState(() => loading = false);
                nextScreenCloseOthers(context, HomePage());
              }));
        }
      });
    }
  }

  // StepperType stepperType = StepperType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Akun',
          style: TextStyle(color: textTitleColors),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    _name = value;
                  },
                  // onSaved: (value) {
                  //   _name = value;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nomer Telephone',
                    icon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    _phoneNumber = value;
                  },
                  // onSaved: (value) {
                  //   _phoneNumber = value;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Alamat Tempat Tinggal',
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    _address = value;
                  },
                  // onSaved: (value) {
                  //   _address = value;
                  // },
                ),
                const SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleUpdateData();
                        // TODO: submit form data to server
                      }
                    },
                    icon: loading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.person_add_alt_1),
                    label: Text(
                      'Daftar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
