import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/bisnis.dart';

class ReviewPage extends StatelessWidget {
  final List<Review>? data;
  const ReviewPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data.isNullOrEmpty()
          ? const Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text('Review Belum Tersedai',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    )),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: 10),
              itemCount: data?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final Review d = data![index];
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 1.5,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(d.pengguna!.name!,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Spacer(),
                                RatingBarIndicator(
                                  rating: d.starRating != null
                                      ? d.starRating.toDouble()
                                      : 0,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Text(d.comments ?? '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                )),
                          ]),
                    ));
              },
            ),
    );
  }
}
