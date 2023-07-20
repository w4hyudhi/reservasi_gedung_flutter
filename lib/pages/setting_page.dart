import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
import 'package:diet_penyakit/configs/Colors.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/pages/about_page.dart';
import 'package:diet_penyakit/pages/register.dart';
import 'package:diet_penyakit/pages/sign_in_page.dart';
import 'package:diet_penyakit/pages/update_profile_page.dart';
import 'package:diet_penyakit/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Uri _url = Uri.parse('https://combine.merauke.website/daftar');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(color: textTitleColors),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
        children: [
          Divider(
            height: 5,
          ),
          // ListTile(
          //     title: Text('edit profile'),
          //     leading: Container(
          //       height: 30,
          //       width: 30,
          //       decoration: BoxDecoration(
          //           color: Colors.purpleAccent,
          //           borderRadius: BorderRadius.circular(5)),
          //       child: Icon(FeatherIcons.edit3, size: 20, color: Colors.white),
          //     ),
          //     trailing: Icon(
          //       FeatherIcons.chevronRight,
          //       size: 20,
          //     ),
          //     // onTap: () => nextScreen(context, UpdateProfilePage())
          //     onTap: () => {}),
          // Divider(
          //   height: 5,
          // ),
          ListTile(
            title: Text('Tentang Pembuat'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Icon(FeatherIcons.info, size: 20, color: Colors.white),
            ),
            trailing: Icon(
              FeatherIcons.chevronRight,
              size: 20,
            ),
            onTap: () async {
              nextScreen(context, AboutPage());
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            title: Text('logout'),
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(FeatherIcons.logOut, size: 20, color: Colors.white),
            ),
            trailing: Icon(
              FeatherIcons.chevronRight,
              size: 20,
            ),
            onTap: () => openLogoutDialog(context),
          ),
          Divider(
            height: 5,
          ),
        ],
      ),
    );
  }

  void openLogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Keluar dari aplikasi?'),
            actions: [
              TextButton(
                child: Text('tidak'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('ya'),
                onPressed: () async {
                  Navigator.pop(context);
                  await context.read<SignInBloc>().userSignout().then(
                      (value) => nextScreenCloseOthers(context, SignInPage()));
                },
              )
            ],
          );
        });
  }
}
