import 'package:diet_penyakit/configs/Colors.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class IconWidget extends StatelessWidget {
  final String name, value;
  final IconData icon;
  const IconWidget(
      {Key? key, required this.name, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black38, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: n,
                fontWeight: FontWeight.w100,
                color: textTitleColors,
              ),
            ),
            Icon(
              icon,
              size: 25,
              color: textTitleColors,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall!.apply(
                    color: textTitleColors,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
