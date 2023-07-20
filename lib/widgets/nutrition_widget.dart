import 'package:diet_penyakit/configs/configs.dart';
import 'package:flutter/material.dart';

class NutritionWidget extends StatelessWidget {
  final String nutrition, value, unit;
  final Color color1, color2;
  const NutritionWidget(
      {Key? key,
      required this.nutrition,
      required this.value,
      required this.unit,
      required this.color1,
      required this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color1,
                color2,
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
            ]),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: m,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nutrition,
                    style: const TextStyle(
                      fontSize: n,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    unit,
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                          color: Colors.white70,
                        ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
