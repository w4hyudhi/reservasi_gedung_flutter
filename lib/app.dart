import 'package:diet_penyakit/blocs/internet_bloc.dart';
import 'package:diet_penyakit/blocs/sawah_bloc.dart';
import 'package:diet_penyakit/blocs/bisnis_bloc.dart';
import 'package:diet_penyakit/blocs/search_block.dart';
import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
import 'package:diet_penyakit/blocs/transaksi_bloc.dart';
import 'package:diet_penyakit/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'configs/configs.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<InternetBloc>(
                create: (context) => InternetBloc(),
              ),
              ChangeNotifierProvider<SignInBloc>(
                create: (context) => SignInBloc(),
              ),
              ChangeNotifierProvider<SawahBloc>(
                create: (context) => SawahBloc(),
              ),
              ChangeNotifierProvider<BisnisBloc>(
                create: (context) => BisnisBloc(),
              ),
              ChangeNotifierProvider<SearchBloc>(
                create: (context) => SearchBloc(),
              ),
              ChangeNotifierProvider<TransaksiBloc>(
                create: (context) => TransaksiBloc(),
              ),
            ],
            child: MaterialApp(
                theme: ThemeData(
                  primaryColor: Config.primaryColor,
                  scaffoldBackgroundColor: Color.fromRGBO(229, 229, 229, 1),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: GoogleFonts.latoTextTheme(),
                  appBarTheme: AppBarTheme(
                    color: Colors.white,
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                debugShowCheckedModeBanner: false,
                // home: BottomNav()),
                home: SplashPage()),
          );
        });
  }
}
