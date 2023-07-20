import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingSlideCard extends StatelessWidget {
  const LoadingSlideCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            )));
  }
}

class LoadingCaborCard extends StatelessWidget {
  const LoadingCaborCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
            margin: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10))));
  }
}

class LoadingCard extends StatelessWidget {
  final double height;
  const LoadingCard({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(3)),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class CustomLoadingCard extends StatelessWidget {
  final double? height;
  final EdgeInsets? pading;
  final EdgeInsets? margin;
  const CustomLoadingCard({Key? key, this.height, this.margin, this.pading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height : MediaQuery.of(context).size.height,
      padding: pading != null ? pading : EdgeInsets.all(0),
      margin: margin != null ? margin : EdgeInsets.all(0),
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          height: height != null ? height : MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
