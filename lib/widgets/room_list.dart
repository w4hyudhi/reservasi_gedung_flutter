import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configs/configs.dart';
import '../pages/hotel_room.dart';
import '../utils/loading_cards copy.dart';
import '../utils/next_screen.dart';

class RoomList extends StatelessWidget {
  final List<Paket>? cb;
  RoomList({Key? key, this.cb}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 15, right: 15),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cb!.isEmpty ? 3 : cb!.length,
        itemBuilder: (BuildContext context, int index) {
          if (cb!.isEmpty) return LoadingCaborCard();
          return ItemList(d: cb![index]);
        },
      ),
    );
  }
}

//final formatCurrency = new NumberFormat("#.##0", "in_ID");
// final formatCurrency = new NumberFormat.currency(locale: "in_ID", symbol: "");

class ItemList extends StatelessWidget {
  final Paket d;

  const ItemList({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###", 'ID');
    return GestureDetector(
      onTap: () =>
          nextScreen(context, HotelRoomPage(data: d, tag: d.id.toString())),
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 0.5,
                blurRadius: 5.0,
              ),
            ]),
        margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: d.id.toString(),
              child: Container(
                height: 140.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: CustomCacheImage(
                    imageUrl: Config().webAdrres + d.path!,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                d.nama!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rp ${formatter.format(d.harga.toDouble())}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return InkWell(
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.red,
    //         borderRadius: BorderRadius.circular(10),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black.withOpacity(0.08),
    //             spreadRadius: 0.5,
    //             blurRadius: 5.0,
    //           ),
    //         ]),
    //     margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
    //     child: Column(
    //       children: [
    //         Hero(
    //           tag: '${d.id}',
    //           child: Container(
    //             width: 150,
    //             height: 200,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: CustomCacheImage(
    //                 imageUrl: d.galery[0],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Text('tess')
    //       ],
    //     ),
    //   ),
    // );
  }
}
