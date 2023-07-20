import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDetailButton extends StatelessWidget {
  final String numb;

  const CustomDetailButton({Key? key, required this.numb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse('https://combine.merauke.website/daftar');
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
                    ]),
                height: 40,
                child: TextButton(
                    onPressed: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: numb,
                      );
                      await launchUrl(launchUri);
                    },
                    style: TextButton.styleFrom(
                        // backgroundColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Theme.of(context).accentColor,
                          size: 25,
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey[400]!, blurRadius: 5)
                    ]),
                height: 40,
                child: TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse('http://wa.me/+62$numb');
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },

                    // onPressed: () => navigateTo(lat, lang),
                    style: TextButton.styleFrom(
                        //backgroundColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CommunityMaterialIcons.whatsapp,
                          color: Colors.green,
                          // color: Theme.of(context).accentColor,
                          size: 25,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
