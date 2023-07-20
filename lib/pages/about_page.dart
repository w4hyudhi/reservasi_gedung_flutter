import 'package:diet_penyakit/configs/Colors.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Pembuat',
          style: TextStyle(color: textTitleColors),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "SISTEM INFORMASI PEMETAAN GEDUNG SERBAGUNA DI KOTA MERAUKE BERBASIS ANDROID",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: l + 2,
                fontWeight: FontWeight.w900,
                color: textTitleColors,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.80,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'WAHYU PUJI SEFRIAN',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: l,
                fontWeight: FontWeight.w700,
                color: textTitleColors,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Sistem Informasi',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: m,
                fontWeight: FontWeight.w600,
                color: textTitleColors,
              ),
            ),
            Text(
              'Fakultas Teknik\nUniversitas Musamus\nMerauke',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: n,
                fontWeight: FontWeight.w600,
                color: textTitleColors,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
