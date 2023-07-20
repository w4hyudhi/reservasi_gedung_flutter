import 'package:diet_penyakit/blocs/bisnis_bloc.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/models/bisnis.dart';
import 'package:diet_penyakit/pages/bisnis_detail.dart';
import 'package:diet_penyakit/pages/detail_gedung.dart';
import 'package:diet_penyakit/utils/loading_cards.dart';
import 'package:diet_penyakit/utils/next_screen.dart';
import 'package:diet_penyakit/widgets/custom_cache_image.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResepList extends StatelessWidget {
  const ResepList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BisnisBloc tb = Provider.of<BisnisBloc>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: tb.hasData == false
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_3,
                      title: 'ooppss...',
                      subTitle:
                          'kami tidak dapat menemukan rekomendasi gedung yang cocok untuk kamu',
                      titleTextStyle: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff9da9c7),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffabb8d6),
                      ),
                      // Uncomment below statement to hide background animation
                      // hideBackgroundAnimation: true,
                    ),
                  ),
                )
              : ListView.separated(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 30, left: 15, right: 15),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      tb.isLoading != true ? tb.data!.dataBisnis!.length : 5,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (tb.isLoading == true) return LoadingCard(height: 200);
                    return _ListItem(d: tb.data!.dataBisnis![index]);
                  },
                ),
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final DataBisnis d;
  const _ListItem({Key? key, required this.d}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Hero(
            tag: d.id.toString(),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CustomCacheImage(imageUrl: Config().webAdrres + d.path!),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.nama!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            d.alamat ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
      onTap: () => nextScreen(context, DetailGedung(data: d)),
    );
  }
}
