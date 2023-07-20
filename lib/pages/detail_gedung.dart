import 'package:community_material_icon/community_material_icon.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/constans.dart';
import '../widgets/custum_detail_button.dart';
import '../widgets/room_list.dart';

class DetailGedung extends StatefulWidget {
  final DataBisnis data;
  const DetailGedung({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailGedung> createState() => _DetailGedungState();
}

class _DetailGedungState extends State<DetailGedung> {
  @override
  Widget build(BuildContext context) {
    final DataBisnis d = widget.data;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                    child: Container(),
                    preferredSize: Size(0, 20),
                  ),
                  // pinned: false,
                  floating: false,
                  snap: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                          child: Container(
                              height: 325,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CustomCacheImage(
                                    imageUrl: Config().webAdrres + d.path!,
                                  ))),
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0),
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
                                    BoxShadow(
                                        color: Colors.grey[400]!, blurRadius: 5)
                                  ]),
                              child: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50),
                            ),
                          ),
                          child: Icon(Icons.arrow_drop_up),
                        ),
                        bottom: -1,
                        left: 0,
                        right: 0,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50),
                          ),
                        ),
                        child: Wrap(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  d.nama!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              d.alamat!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          'contact',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.grey[700],
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              d.telepon ?? '',
                                              style: Constants.Body1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Colors.grey[700],
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              d.email ?? '',
                                              style: Constants.Body1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (d.website != '')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CommunityMaterialIcons.web,
                                              color: Colors.grey[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                d.website ?? '',
                                                style: Constants.Body1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (d.facebook != '')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CommunityMaterialIcons.facebook,
                                              color: Colors.grey[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                d.facebook ?? '',
                                                style: Constants.Body1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (d.instagram != '')
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CommunityMaterialIcons.instagram,
                                              color: Colors.grey[700],
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                d.instagram ?? '',
                                                style: Constants.Body1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      CustomDetailButton(
                                        numb: d.telepon!,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          'Paket Tersedia',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RoomList(cb: d.paket),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    'Deskripsi',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: HtmlWidget(d.deskripsi!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
