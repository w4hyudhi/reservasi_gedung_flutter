import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:photo_view/photo_view.dart';

import '../configs/configs.dart';

class DetailScreen extends StatefulWidget {
  final String tag;
  final String url;
  final String nama;
  final String ket;

  DetailScreen(
      {Key? key,
      required this.tag,
      required this.url,
      required this.nama,
      required this.ket})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // @override
  // initState() {
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   //SystemChrome.restoreSystemUIOverlays();
  //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.nama,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 300,
                child: Hero(
                  tag: widget.tag,
                  child: CachedNetworkImage(
                    imageUrl: Config().webAdrres + widget.url,
                    imageBuilder: (context, imageProvider) => PhotoView(
                      imageProvider: imageProvider,
                    ),
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: HtmlWidget(widget.ket),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
