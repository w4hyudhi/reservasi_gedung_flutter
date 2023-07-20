// import 'package:diet_penyakit/blocs/internet_bloc.dart';
// import 'package:diet_penyakit/blocs/sawah_bloc.dart';
// import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
// import 'package:diet_penyakit/models/penyakit.dart';
// import 'package:diet_penyakit/pages/home_page.dart';
// import 'package:diet_penyakit/pages/snacbar.dart';
// import 'package:diet_penyakit/utils/next_screen.dart';
// import 'package:diet_penyakit/widgets/Buttons.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
// import 'package:provider/provider.dart';

// class PenyakitPage extends StatefulWidget {
//   PenyakitPage({Key? key}) : super(key: key);

//   @override
//   State<PenyakitPage> createState() => _PenyakitPageState();
// }

// class _PenyakitPageState extends State<PenyakitPage> {
//   late String penyakit;
//   ButtonState stateText = ButtonState.idle;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   final List<Penyakit> _penyakit = [];

//   handleUpdateData() async {
//     final sb = context.read<SignInBloc>();
//     final ib = context.read<InternetBloc>();
//     setState(() => stateText = ButtonState.loading);
//     await ib.checkInternet();
//     if (ib.checkInternet() == false) {
//       setState(() => stateText = ButtonState.fail);
//       // openSnacbar(scaffoldKey, 'check your internet connection!');
//       // } else {
//       //   sb.saveUserData(penyakit.toString()).then((value) {
//       //     if (value != true) {
//       //       // openSnacbar(scaffoldKey, 'something is wrong. please try again.');
//       //       setState(() => stateText = ButtonState.fail);
//       //     } else {
//       //       sb.saveDataToSP().then((value) => sb.setSignIn().then((value) {
//       //             setState(() => stateText = ButtonState.success);
//       //             nextScreen(context, HomePage());
//       //           }));
//       //     }
//       //   });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(milliseconds: 0)).then((value) {
//       context.read<PenyakitBloc>().getData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sb = context.watch<PenyakitBloc>();
//     Size size = MediaQuery.of(context).size;
//     // final _items = sb.dataPenyakit!.data!
//     //     .map((sakit) => MultiSelectItem<String?>(sakit.nama, sakit.nama!))
//     //     .toList();

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: sb.isLoading == true
//               ? Center(
//                   child: LoadingAnimationWidget.twistingDots(
//                       leftDotColor: Colors.blue,
//                       rightDotColor: Colors.yellow,
//                       size: 50))
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(height: 40),
//                     Text("Penyakit Yang Di Derita"),
//                     MultiSelectChipField<String?>(
//                       items: sb.dataPenyakit!.data!
//                           .map((sakit) =>
//                               MultiSelectItem<String?>(sakit.nama, sakit.nama!))
//                           .toList(),
//                       scroll: false,
//                       showHeader: false,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.transparent, width: 0),
//                       ),
//                       selectedChipColor: Colors.blue.withOpacity(0.5),
//                       selectedTextStyle: TextStyle(color: Colors.blue[800]),
//                       onTap: (values) {
//                         // _selectedAnimals4 = values;
//                         penyakit = values.toString();
//                         print("isi" + values.toString());
//                       },
//                     ),
//                     ProgressButton.icon(
//                         iconedButtons: {
//                           ButtonState.idle: IconedButton(
//                               text: "Send",
//                               icon: Icon(Icons.send, color: Colors.white),
//                               color: Colors.deepPurple.shade500),
//                           ButtonState.loading: IconedButton(
//                               text: "Loading",
//                               color: Colors.deepPurple.shade700),
//                           ButtonState.fail: IconedButton(
//                               text: "Failed",
//                               icon: Icon(Icons.cancel, color: Colors.white),
//                               color: Colors.red.shade300),
//                           ButtonState.success: IconedButton(
//                               text: "Success",
//                               icon: Icon(
//                                 Icons.check_circle,
//                                 color: Colors.white,
//                               ),
//                               color: Colors.green.shade400)
//                         },
//                         onPressed: () async {
//                           handleUpdateData();
//                         },
//                         state: stateText),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
