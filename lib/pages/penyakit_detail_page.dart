import 'package:diet_penyakit/configs/Colors.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/penyakit.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class PenyakitDetailPage extends StatefulWidget {
  final Data data;
  final String tag;

  PenyakitDetailPage({Key? key, required this.tag, required this.data})
      : super(key: key);

  @override
  State<PenyakitDetailPage> createState() => _PenyakitDetailPageState();
}

class _PenyakitDetailPageState extends State<PenyakitDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Data d = widget.data;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
                        ]),
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Hero(
            tag: widget.tag,
            child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CustomCacheImage(
                      imageUrl:
                          Config().webAdrres + 'images/penyakit/' + d.images!,
                    ))),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            d.nama!.toUpperCase(),
            style: GoogleFonts.openSans(
              fontSize: l + 2,
              fontWeight: FontWeight.bold,
              color: textTitleColors,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          HtmlWidget(d.keterangan!),
          SizedBox(
            height: 10,
          )
        ]),
      )),
    );
  }
}
