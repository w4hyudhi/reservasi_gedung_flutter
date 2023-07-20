import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:diet_penyakit/blocs/bisnis_bloc.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:diet_penyakit/utils/map_util.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/next_screen.dart';
import 'detail_gedung.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final geolocator = Geolocator();
  Position? _currentPosition;
  List _markers = [];
  late PageController _pageController;
  List<DataBisnis> _alldata = [];
  int? prevPage;
  late GoogleMapController _controller;
  bool data = false;

  void openEmptyDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Text("we didn't find any nearby place in this area"),
              title: Text(
                'no place found',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pop(true);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            ),
          );
        });
  }

  double getDistance(double latitude, double longitude) {
    double distanceInMeters = 0.0;
    try {
      distanceInMeters = Geolocator.distanceBetween(_currentPosition!.latitude,
          _currentPosition!.longitude, latitude, longitude);
    } catch (e) {
      distanceInMeters = 0.0;
    }
    return distanceInMeters;
  }

  void _onScroll() {
    if (_pageController.page?.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            (_alldata[_pageController.page!.toInt()].latitude!).toDouble(),
            (_alldata[_pageController.page!.toInt()].longitude!).toDouble()),
        zoom: 20,
        bearing: 45.0,
        tilt: 45.0)));
  }

  Future _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition!.latitude);
      });
      // addMarker().then((value) {

      _addMarker();
      // });
    }).catchError((e) {
      print(e);
    });
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
    return _getCurrentLocation();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 0)).then((value) async {
      getData().then((value) => _addMarker().then((value) => data = true));

      _determinePosition();
    });

    _pageController = PageController(initialPage: 0, viewportFraction: 0.83)
      ..addListener(_onScroll);
  }

  Future getData() async {
    final dt = context.read<BisnisBloc>();
    _alldata.clear();
    _alldata = dt.data!.dataBisnis!;
  }

  Future _addMarker() async {
    int index = 0;
    _markers.clear();
    _alldata.map((i) {
      index++;
      print("add marker");
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(i.id.toString()),
          position: LatLng((i.latitude!).toDouble(), (i.longitude!).toDouble()),
          infoWindow: InfoWindow(title: i.nama),
          onTap: () {
            // print('print = $index');
            setState(() {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.elasticInOut);
            });
          },
        ));
      });
    }).toList();
  }

  void onMapCreated(controller) {
    controller.setMapStyle(MapUtils.mapStyles);
    setState(() {
      _controller = controller;
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

  void animateCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      zoom: 15,
    )));
  }

  Widget _myLocationWidget() {
    return InkWell(
      onTap: () {
        setState(() {
          if (_currentPosition != null) {
            animateCamera();
            _getCurrentLocation();
          } else {
            _getCurrentLocation().then((value) => animateCamera());
          }
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
            ]),
        child: Icon(
          Icons.location_on,
          color: Colors.blue,
        ),
      ),
    );
  }

  String convertDistance(double distance) {
    String jarak = '';
    final formatterKm = new NumberFormat("#0.00");
    final formatterM = new NumberFormat("#0");

    try {
      if (distance <= 1000) {
        jarak = formatterM.format(distance) + " meter";
      } else {
        jarak = formatterKm.format(distance / 1000) + " kilometer";
      }
    } catch (e) {
      jarak = '';
    }
    return jarak;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: Config().initialCameraPosition,
                      mapType: MapType.normal,
                      onMapCreated: (controller) => onMapCreated(controller),
                      markers: Set.from(_markers),
                      compassEnabled: false,
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      cameraTargetBounds: CameraTargetBounds.unbounded,
                      myLocationButtonEnabled: false,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: true,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              curve: Curves.elasticInOut,
              bottom: data ? 30 : -200,

              //top: 55,
              left: 0,
              right: 0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _alldata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _detailList(index);
                  },
                ),
              ),
            ),
            Positioned(
                top: 20,
                left: 15,
                right: 15,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
                            ]),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 7, bottom: 7, right: 25),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey[400]!, blurRadius: 5)
                                  ]),

                              child: Text(
                                'Lokasi Gedung',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              // child: CachedNetworkImage(
                              //   imageUrl: widget.data.image,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _myLocationWidget()
                  ],
                )),
            _alldata.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  _detailList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey[300]!, blurRadius: 5)
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: _alldata[index].id.toString(),
                child: Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: CustomCacheImage(
                            imageUrl:
                                Config().webAdrres + _alldata[index].path!))),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          _alldata[index].nama!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place,
                              color: Theme.of(context).accentColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                _alldata[index].alamat!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.car_rental,
                              color: Theme.of(context).accentColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                convertDistance(getDistance(
                                    _alldata[index].latitude!.toDouble(),
                                    _alldata[index].longitude!.toDouble())),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: 25,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),

                                // materialTapTargetSize:
                                //     MaterialTapTargetSize.shrinkWrap,
                                // height: 25,
                                onPressed: () {
                                  nextScreen(context,
                                      DetailGedung(data: _alldata[index]));
                                  // onCardTap(
                                  //     context,
                                  //     Config().webAdrres +
                                  //         _alldata[index].foto!,
                                  //     _alldata[index].id.toString(),
                                  //     _alldata[index].nama,
                                  //     _alldata[index].alamat,
                                  //     _alldata[index].jadwal,
                                  //     _alldata[index].hp);
                                },
                                // label: Text('Direction'),
                                // icon: Icon(FontAwesome.location_arrow),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.details,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    AutoSizeText(
                                      'DETAIL',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),

                                // materialTapTargetSize:
                                //     MaterialTapTargetSize.shrinkWrap,
                                // height: 25,
                                onPressed: () {
                                  navigateTo(
                                      _alldata[index].latitude!.toDouble(),
                                      _alldata[index].longitude!.toDouble());
                                },
                                // label: Text('Direction'),
                                // icon: Icon(FontAwesome.location_arrow),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.navigation,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    AutoSizeText(
                                      'RUTE',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 150.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: child,
          ),
        );
      },
    );
  }

  static void navigateTo(double lat, double lng) async {
    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final Uri url = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (!await launchUrl(url)) throw 'Could not launch $url';

    //MapsLauncher.launchCoordinates(lat, lng, 'Google Headquarters are here');
  }
}
