// import 'package:diet_penyakit/pages/jadwal_page.dart';
// import 'package:diet_penyakit/pages/order_page.dart';
// import 'package:flutter/material.dart';

// import 'package:diet_penyakit/models/bisnis.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import '../configs/Colors.dart';
// import '../configs/configs.dart';
// import '../utils/next_screen.dart';
// import '../widgets/custom_cache_image.dart';

// class BisnisDetail extends StatefulWidget {
//   final DataBisnis data;
//   final String tag;
//   const BisnisDetail({
//     Key? key,
//     required this.data,
//     required this.tag,
//   }) : super(key: key);

//   @override
//   State<BisnisDetail> createState() => _BisnisDetailState();
// }

// class _BisnisDetailState extends State<BisnisDetail> {
//   late double _panelHeightOpen;
//   late double _panelHeightClosed;
//   @override
//   Widget build(BuildContext context) {
//     final DataBisnis d = widget.data;
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     _panelHeightOpen = h * 1;
//     _panelHeightClosed = h * 0.64;
//     return Scaffold(
//         body: SafeArea(
//             child: Stack(
//       children: [
//         SlidingUpPanel(
//             maxHeight: _panelHeightOpen,
//             minHeight: _panelHeightClosed,
//             parallaxEnabled: true,
//             parallaxOffset: .5,
//             borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Colors.grey[400]!, blurRadius: 4, offset: Offset(1, 0))
//             ],
//             padding: EdgeInsets.only(top: 15, left: 10, bottom: 0, right: 10),
//             panelBuilder: (sc) => panelUI(sc, d),
//             //  panelBuilder: (sc) => _panel(sc),
//             body: panelBodyUI(h, w, d, widget.tag)),
//       ],
//     )));
//   }

//   Widget panelBodyUI(h, w, DataBisnis d, t) {
//     return Container(
//       width: w,
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Hero(
//                 tag: t,
//                 child: Container(
//                   height: h * 0.35,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       // borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.4),
//                           spreadRadius: 0.5,
//                           blurRadius: 5.0,
//                         ),
//                       ]),
//                   width: MediaQuery.of(context).size.width,
//                   child: ClipRRect(
//                     // borderRadius: BorderRadius.circular(10),
//                     child: CustomCacheImage(
//                       imageUrl: Config().webAdrres + d.url!,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 left: 15,
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(50),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
//                         ]),
//                     child: const Icon(
//                       Icons.arrow_back_ios_sharp,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget panelUI(ScrollController sc, DataBisnis d) {
//     return Material(
//       color: Colors.white,
//       child: MediaQuery.removePadding(
//         context: context,
//         removeTop: true,
//         child: ListView(
//           controller: sc,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 5, right: 5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 30,
//                         height: 5,
//                         decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12.0))),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           d.bisnisName!.toUpperCase(),
//                           style: GoogleFonts.openSans(
//                             fontSize: l + 2,
//                             fontWeight: FontWeight.bold,
//                             color: textTitleColors,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(Icons.location_on),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 d.addres!,
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(Icons.phone),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 d.phonenumber!,
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Deskripsi',
//                           style: GoogleFonts.openSans(
//                             fontSize: l,
//                             fontWeight: FontWeight.w600,
//                             color: textTitleColors,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         HtmlWidget(d.price!),
//                         SizedBox(
//                           height: 25,
//                         ),
//                         ListView.builder(
//                           itemCount: d.combine?.length,
//                           shrinkWrap: true,
//                           itemBuilder: (BuildContext context, int index) {
//                             return InkWell(
//                               onTap: () => nextScreen(
//                                   context,
//                                   JadwalPage(
//                                     data: d.combine![index].transaksi,
//                                   )),
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.2),
//                                       spreadRadius: 0,
//                                       blurRadius: 1.5,
//                                       offset: Offset(0, 0),
//                                     )
//                                   ],
//                                 ),
//                                 child: ListTile(
//                                   leading: Container(
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(5),
//                                       child: CustomCacheImage(
//                                           imageUrl: Config().webAdrres +
//                                               d.combine![index].url!),
//                                     ),
//                                   ),
//                                   title: Text(d.combine![index].merek!),
//                                   subtitle: Text(d.combine![index].transaksi!
//                                               .length ==
//                                           0
//                                       ? 'jadwal kosong'
//                                       : 'jadwal : ${d.combine![index].transaksi!.length} orderan'),
//                                   trailing: Container(
//                                     child: Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.green,
//                                       size: 35.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       nextScreen(
//                           context,
//                           OrderForm(
//                             bisnis_id: d.id.toString(),
//                           ));
//                     },
//                     child: Text(
//                       "Order Sekarang",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue, // Warna latar belakang tombol
//                       onPrimary: Colors.white, // Warna teks pada tombol
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8), // Jarak antara teks dan tepi tombol
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             16), // Mengatur radius sudut tombol
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 70,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
