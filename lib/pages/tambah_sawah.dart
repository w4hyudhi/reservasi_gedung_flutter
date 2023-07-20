import 'package:diet_penyakit/blocs/internet_bloc.dart';
import 'package:diet_penyakit/blocs/sawah_bloc.dart';
import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:diet_penyakit/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TambahSawah extends StatefulWidget {
  // const TambahSawah({super.key});

  @override
  State<TambahSawah> createState() => _TambahSawahState();
}

class _TambahSawahState extends State<TambahSawah> {
  final Geolocator geolocator = Geolocator();
  Position? _currentPosition;
  late GoogleMapController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _luasController = TextEditingController();
  final Set<Marker> _markers = {};
  bool loading = false;

  LatLng? _selectedLatLng;
  String? _address;
  String? _name;
  String? _luas;
  String? _latitude;
  String? _longitude;
  String error4 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  handleUpdateData() async {
    final sb = context.read<SawahBloc>();
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
      sb
          .saveSawah(_name!, _address!, _luas!, _latitude!, _longitude!)
          .then((value) {
        if (value != true) {
          openSnacbar(context, 'something is wrong. please try again.');
          setState(() {
            loading = false;
            error4 = 'Gagal menyimpan data';
          });
        } else {
          openSnacbar(context, 'sawah berhasil ditambah.');
          context.read<SawahBloc>().getData().then((value) {
            setState(() => loading = false);
            Navigator.of(context).pop(true);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _luasController.dispose();
    super.dispose();
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return toMyLocation();
  }

  Future _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition!.latitude);
      });
      // addMarker().then((value) {

      // });
    }).catchError((e) {
      print(e);
    });
  }

  void animateCameraUp() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      zoom: 12,
    )));
  }

  Future toMyLocation() async {
    if (_currentPosition != null) {
      animateCameraUp();
      _getCurrentLocation();
    } else {
      _getCurrentLocation().then((value) => animateCameraUp());
    }
  }

  void _onMapCreated(controller) {
    // controller.setMapStyle(MapUtils.mapStyles);
    setState(() {
      _controller = controller;
    });
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: latLng,
        ),
      );
      _selectedLatLng = latLng;
      _latitude = latLng.latitude.toString();
      _longitude = latLng.longitude.toString();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('$_name $_address $_luas $_latitude $_longitude');
      handleUpdateData();
      // Kirim data alamat ke server atau lakukan operasi lainnya.
      // print('Alamat berhasil ditambahkan: $_selectedLatLng, $_address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Alamat'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'nama tidak boleh kosong.';
                    }
                    _name = value;
                  },
                  // onSaved: (value) {
                  //   _name = value!;
                  // },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Alamat Lengkap',
                  ),
                  controller: _addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat tidak boleh kosong.';
                    }
                    _address = value;
                  },
                  // onSaved: (value) {
                  //   _address = value!;
                  // },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Luas Sawah',
                  ),
                  controller: _luasController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Luas Sawah tidak boleh kosong.';
                    }
                    _luas = value;
                  },
                  // onSaved: (value) {
                  //   _luas = value!;
                  // },
                ),
                SizedBox(height: 16),
                Container(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    onTap: _onMapTap,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(-8.490552412519914, 140.40063192838412),
                      zoom: 10,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _selectedLatLng == null ? null : _submitForm,
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
                        : const Icon(Icons.add),
                    label: Text(
                      'Tambah Sawah',
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
