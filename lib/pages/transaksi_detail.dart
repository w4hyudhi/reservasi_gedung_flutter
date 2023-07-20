import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../blocs/internet_bloc.dart';
import '../blocs/transaksi_bloc.dart';
import '../configs/configs.dart';
import '../models/transaksi_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/next_screen.dart';
import 'home_page.dart';

class DetailTransaksi extends StatefulWidget {
  final DataTransaksi data;
  const DetailTransaksi({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  bool _isSaving = false;

  String error = '';
  String ratting = '';
  String booking_id = '';
  String comments = '';
  final formatter = new NumberFormat("#,###", 'ID');
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'success':
        return Colors.green;
      case 'accept':
        return Colors.blue;
      case 'reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  handleUpdateData() async {
    final sb = context.read<TransaksiBloc>();
    final ib = context.read<InternetBloc>();
    setState(() => _isSaving = true);
    await ib.checkInternet();
    if (ib.checkInternet() == false) {
      setState(() {
        _isSaving = false;
        error = 'Koneksi internet bermasalah';
      });
      // openSnacbar(scaffoldKey, 'check your internet connection!');
    } else {
      sb.saveRating(booking_id, ratting, comments).then((value) {
        if (value != true) {
          // openSnacbar(scaffoldKey, 'something is wrong. please try again.');
          setState(() {
            _isSaving = false;
            error = 'Gagal menyimpan data';
          });
        } else {
          setState(() => _isSaving = false);
          openSnacbar(context, "Ratting berhasil diberikan");
          nextScreenCloseOthers(context, HomePage());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DataTransaksi data = widget.data;
    booking_id = data.id.toString();

    // String? timeString = data.jam ?? '00:00:00';
    // String? dateString = data.tanggal;
    DateTime dateTime = DateTime.parse(data.createdAt!);
    DateTime dateTimeIn = DateTime.parse(data.dateIn!);
    DateTime dateTimeOut = DateTime.parse(data.dateOut!);
    String? formattedTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    String? formattedDateIn = DateFormat('dd/MM/yyyy').format(dateTimeOut);
    String? formattedDateOut = DateFormat('dd/MM/yyyy').format(dateTimeOut);

    // int price = data.untung.toInt();
    // String formattedPrice =
    //     NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
    //         .format(price);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Detail Booking",
            style: TextStyle(
              color: Color.fromRGBO(33, 45, 82, 1),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CustomCacheImage(
                      imageUrl: Config().webAdrres + (data.gedung?.path)!),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(data.gedung?.nama ?? '',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(data.paket?.nama ?? '',
                  style: TextStyle(fontSize: 15.0)),
            ),
            SizedBox(
              height: 10,
            ),
            data.review == null
                ? InkWell(
                    onTap: _showRatingAppDialog,
                    child: Text("Beri Ulasan",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )))
                : RatingBarIndicator(
                    rating: data.review != null
                        ? data.review!.starRating!.toDouble()
                        : 0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('STATUS : ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text((data.status!).toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(data.status!)))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Tanggal:",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                formattedTime,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "No Refrensi",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                data.noRef!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Alasan",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                data.nama!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Kapasitas",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                " ${data.paket?.kapasitasRuangan! ?? ''} Kursi",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Tanggal Mulai",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                formattedDateIn,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Tanggal Selesai",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                formattedDateOut,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Jam Mulai",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                data.timeIn!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Jam Selesai",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                data.timeOut!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Divider(thickness: 2),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Biaya Sewa",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                'Rp ${formatter.format(data.harga!.toDouble())}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Durasi",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Text(
                data.durasi! + ' Hari',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Divider(thickness: 2),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${formatter.format(data.total!.toDouble())}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ]),
          ]),
        )),
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        widget.data.paket!.nama!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'beri ratting dan ulasan untuk paket ini',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?

      submitButtonText: 'Review',
      commentHint: 'isi ulasan kamu',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        ratting = response.rating.toString();
        comments = response.comment.toString();
        handleUpdateData();
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
