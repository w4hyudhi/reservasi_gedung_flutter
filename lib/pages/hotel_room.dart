import 'package:diet_penyakit/models/bisnis.dart';
import 'package:diet_penyakit/pages/booking_page.dart';
import 'package:diet_penyakit/pages/review_page.dart';
import 'package:diet_penyakit/widgets/hotel_info.dart';
import 'package:diet_penyakit/widgets/room_galery.dart';
import 'package:flutter/material.dart';

import '../configs/configs.dart';
import '../utils/next_screen.dart';
import 'jadwal_page.dart';

class HotelRoomPage extends StatefulWidget {
  final Paket data;
  final String tag;
  const HotelRoomPage({Key? key, required this.data, required this.tag})
      : super(key: key);
  @override
  _HotelRoomPageState createState() => _HotelRoomPageState();
}

class _HotelRoomPageState extends State<HotelRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: <Widget>[
          HotelFeedBodyBackground(hotel: widget.data),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: HotelFeedBody(hotel: widget.data),
            ),
          ),
        ],
      ),
    );
  }
}

class HotelFeedBodyBackground extends StatelessWidget {
  const HotelFeedBodyBackground({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Paket hotel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).size.height * .60,
      child: Hero(
        tag: hotel.id.toString(),
        child: Container(
          height: MediaQuery.of(context).size.height * .25,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(Config().webAdrres + hotel.path!),
                fit: BoxFit.cover),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .25,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0, .8),
                    end: Alignment(0, 0),
                    colors: [
                  Color(0xEE000000),
                  Color(0x33000000),
                ])),
          ),
        ),
      ),
    );
  }
}

class HotelFeedBody extends StatelessWidget {
  final Paket hotel;

  const HotelFeedBody({Key? key, required this.hotel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 32, right: 32, bottom: 60, top: 144),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 8),
                Expanded(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    elevation: 8,
                    child: Container(
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              padding: EdgeInsets.all(5),
                              indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(15), // Creates border
                                color: Colors.blue.shade100,
                              ),
                              // indicatorWeight: 5,
                              tabs: [
                                Tab(
                                  child: Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                                Tab(
                                  child: Icon(
                                    Icons.space_dashboard,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                                Tab(
                                  child: Icon(
                                    Icons.reviews,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                                Tab(
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 0, color: Colors.black),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: TabBarView(
                                  children: [
                                    SingleChildScrollView(
                                        child:
                                            HotelInformationTab(hotel: hotel)),
                                    RoomGalery(hotel: hotel.galeri!),
                                    ReviewPage(data: hotel.review),
                                    JadwalPage(data: hotel.booking),
                                    // RoomGalery(hotel: hotel),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        nextScreen(
                                            context,
                                            BookingScreen(
                                              ruangan_id: hotel.id.toString(),
                                              harga: hotel.harga.toString(),
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 15),
                                        backgroundColor: Colors.blue,
                                        textStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      child: Text('Pesan Sekarang'),
                                    ),
                                  ),
                                  // Widget lain dalam baris jika diperlukan
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 15,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
                    ]),
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
