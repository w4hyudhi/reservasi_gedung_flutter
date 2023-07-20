import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/widgets/detail_screen_state.dart';
import 'package:flutter/material.dart';

import '../models/bisnis.dart';
import 'custom_cache_image.dart';

class RoomGalery extends StatelessWidget {
  final List<Galeri> hotel;
  RoomGalery({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 10),
        itemCount: hotel.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          Galeri data = hotel[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: data.id.toString() + 'foto',
              child: Container(
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCacheImage(
                      imageUrl: Config().webAdrres + data.path!,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailScreen(
                          nama: data.nama!,
                          ket: data.deskripsi!,
                          tag: data.id.toString() + 'foto',
                          url: data.path!);
                    }));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
