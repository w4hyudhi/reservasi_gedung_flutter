import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import '../models/bisnis.dart';

class HotelInformationTab extends StatefulWidget {
  HotelInformationTab({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Paket hotel;

  @override
  _HotelInformationTabState createState() => _HotelInformationTabState();
}

class _HotelInformationTabState extends State<HotelInformationTab> {
  double totalRating = 0;
  var selected = false;
  final formatter = new NumberFormat("#,###", 'ID');

  @override
  Widget build(BuildContext context) {
    Paket d = widget.hotel;
    d.review?.forEach((review) {
      totalRating += review.starRating.toDouble();
    });
    double averageRating = totalRating / d.review!.length.toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBarIndicator(
          rating: totalRating != 0 ? averageRating : 0,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.grey,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                child: Text(
                  'Kapasitas ' + d.kapasitasRuangan.toString() + ' Kursi',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Text(
              'Rp ${formatter.format(d.harga.toDouble())}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          d.nama!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Divider(height: 2, color: Colors.grey),
        HtmlWidget(d.deskripsi!),
      ],
    );
  }
}
