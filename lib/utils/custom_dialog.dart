import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../configs/configs.dart';

class CustomDialog extends StatelessWidget {
  final String mulai;
  final String selesai;
  final String nama;
  final double amount;
  final int distance;
  final double total;
  const CustomDialog(
      {Key? key,
      required this.nama,
      required this.amount,
      required this.distance,
      required this.mulai,
      required this.selesai,
      required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###", 'ID');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.currency_exchange,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ),
            SizedBox(height: 10),
            Column(children: [
              Text(
                'Detail Booking',
                style: GoogleFonts.inter(
                  fontSize: 26.0,
                  color: Color.fromRGBO(138, 150, 191, 1),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                nama,
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  color: Color.fromRGBO(138, 150, 191, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Tanggal:",
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  mulai,
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Lama Acara:",
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  distance.toString() + ' Hari',
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "harga gedung:",
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Rp ${formatter.format(amount)}',
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "TOTAL:",
                  style: GoogleFonts.inter(
                    fontSize: 24.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp ${formatter.format(total)}',
                  style: GoogleFonts.inter(
                    fontSize: 24.0,
                    color: Color.fromRGBO(138, 150, 191, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ]),
            SizedBox(height: 30),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(40.0),
                decoration: BoxDecoration(
                  color: Config.primaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(169, 176, 185, 0.42),
                      spreadRadius: 0,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Booking Tempat',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
