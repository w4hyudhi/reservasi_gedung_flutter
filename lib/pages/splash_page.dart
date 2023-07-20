import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/pages/home_page.dart';
import 'package:diet_penyakit/pages/sign_in_page.dart';
import 'package:diet_penyakit/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/Colors.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      sb.isSignedIn == true || sb.guestUser == true
          ? gotoHomePage()
          : gotoSignInPage();
    });
  }

  gotoHomePage() {
    //final SignInBloc sb = context.read<SignInBloc>();
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb
          .getDataFromSp()
          .then((value) => nextScreenReplace(context, HomePage()));
    }
  }

  gotoSignInPage() {
    nextScreenReplace(context, SignInPage());
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    afterSplash();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FadeTransition(
        opacity: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(Config().splashIcon),
              height: 220,
              width: 220,
              fit: BoxFit.contain,
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
            )
          ],
        ),
      )),
    );
  }
}
