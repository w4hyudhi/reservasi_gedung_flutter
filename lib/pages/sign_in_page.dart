import 'package:diet_penyakit/blocs/internet_bloc.dart';
import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
import 'package:diet_penyakit/configs/Colors.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/pages/home_page.dart';
import 'package:diet_penyakit/pages/register.dart';
import 'package:diet_penyakit/pages/register_profile_page.dart';
import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:diet_penyakit/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool googleSignInStarted = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final Uri _url = Uri.parse('https://combine.merauke.website/daftar');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  handleGoogleSignIn() async {
    final sb = context.read<SignInBloc>();
    final ib = context.read<InternetBloc>();
    setState(() => googleSignInStarted = true);
    await ib.checkInternet();
    if (ib.checkInternet() == false) {
      openSnacbar(scaffoldKey, 'check your internet connection!');
    } else {
      sb.signInWithGoogle().then((_) {
        if (sb.hasError == true) {
          openSnacbar(scaffoldKey, 'something is wrong. please try again.');
          setState(() => googleSignInStarted = false);
        } else {
          sb.checkUserExists().then((value) {
            print('isi data' + value.toString());
            if (value == true) {
              sb.getUserDatafromServer(sb.uid).then((value) => sb
                  .saveDataToSP()
                  .then((value) => sb.guestSignout())
                  .then((value) => sb.setSignIn().then((value) {
                        setState(() => googleSignInStarted = false);
                        nextScreenCloseOthers(context, HomePage());
                      })));
            } else {
              setState(() => googleSignInStarted = false);
              nextScreen(context, RegisterProfilePage());
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Reservasi Gedung Serbaguna',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textTitleColors,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GoogleAuthButton(
                    onPressed: () {
                      handleGoogleSignIn();
                    },
                    isLoading: googleSignInStarted == false ? false : true,
                    darkMode: false,
                    style: const AuthButtonStyle(
                      buttonType: AuthButtonType.secondary,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              )),
        ],
      ),
    );
  }
}
