// import 'dart:convert';

// import 'package:diet_penyakit/blocs/internet_bloc.dart';
// import 'package:diet_penyakit/blocs/penyakit_bloc.dart';
// import 'package:diet_penyakit/configs/Colors.dart';

// import 'package:diet_penyakit/models/penyakit.dart';
// import 'package:diet_penyakit/pages/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:diet_penyakit/blocs/sign_in_bloc.dart';

// import 'package:diet_penyakit/utils/next_screen.dart';
// import 'package:diet_penyakit/utils/validators.dart';

// import 'package:diet_penyakit/widgets/InputFeiled.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';

// import 'package:provider/provider.dart';

// class UpdateProfilePage extends StatefulWidget {
//   UpdateProfilePage({Key? key}) : super(key: key);

//   @override
//   State<UpdateProfilePage> createState() => _UpdateProfilePageState();
// }

// class _UpdateProfilePageState extends State<UpdateProfilePage> {
//   int _currentStep = 0;
//   final _formKey = GlobalKey<FormState>();
//   var nameCtrl = TextEditingController();

//   // String penyakit = '';

//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   List<String?> _penyakit = [];
//   String error = '';
//   String error2 = '';
//   String error3 = '';
//   String error4 = '';
//   bool loading = false;

//   var a = [];

//   String? nama;

//   int? age;

//   int? weight;

//   int? height;

//   String _gnder = ' ';
//   Color activeColor = Color.fromARGB(255, 33, 127, 250);

//   final List<Goal> _goals = [
//     Goal("Menambah Berat Badan", "assets/images/gain_undraw.svg"),
//     Goal("Menjaga Berat Badan", "assets/images/maintain_undraw.svg"),
//     Goal("Mengurangi Berat", "assets/images/Lose_undraw.svg"),
//   ];

//   int selectedIndexGoal = -1;

//   final List<Activity> _activites = [
//     Activity("Berat", "assets/images/undraw_veryActive.svg"),
//     Activity("Sedang", "assets/images/undraw_modrate.svg"),
//     Activity("Ringan", "assets/images/undraw_light.svg"),
//     Activity("Santai", "assets/images/undraw_sedentary.svg"),
//   ];

//   int selectedIndex = -1;
//   // Color activeColor = EDPurple0;
//   Color inactiveColor = Colors.grey;

//   handleUpdateData() async {
//     final sb = context.read<SignInBloc>();
//     final ib = context.read<InternetBloc>();
//     setState(() => loading = true);
//     await ib.checkInternet();
//     if (ib.checkInternet() == false) {
//       setState(() {
//         loading = false;
//         error4 = 'Koneksi internet bermasalah';
//       });
//       // openSnacbar(scaffoldKey, 'check your internet connection!');
//     } else {
//       sb
//           .updateUserData(nama!, json.encode(_penyakit), age!, weight!, height!,
//               _gnder, selectedIndexGoal, selectedIndex)
//           .then((value) {
//         if (value != true) {
//           // openSnacbar(scaffoldKey, 'something is wrong. please try again.');
//           setState(() {
//             loading = false;
//             error4 = 'Gagal menyimpan data';
//           });
//         } else {
//           sb.saveDataToSP().then((value) =>
//               sb.setSignIn().then((value) => sb.updateNutrition().then((value) {
//                     setState(() => loading = false);
//                     nextScreenCloseOthers(context, HomePage());
//                   })));
//         }
//       });
//     }
//   }

//   @override
//   void initState() {
//     setState(() {
//       final user = context.read<SignInBloc>();
//       _gnder = user.gender!;

//       selectedIndexGoal = user.goal!;
//       selectedIndex = user.activites!;
//       nama = user.name!;
//       age = user.age;
//       weight = user.weight!;
//       height = user.height!;

//       var streetsFromJson = json.decode(user.disease!);
//       _penyakit = new List<String>.from(streetsFromJson);

//       print('penyakit ' + a.toString());
//     });
//     Future.delayed(Duration(milliseconds: 0)).then((value) {
//       context.read<PenyakitBloc>().getData();
//     });
//     super.initState();
//   }

//   // StepperType stepperType = StepperType.horizontal;

//   @override
//   Widget build(BuildContext context) {
//     final sb = context.watch<PenyakitBloc>();

//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'DAFTAR',
//           style: TextStyle(color: textTitleColors),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: Stepper(
//                 type: StepperType.horizontal,
//                 physics: ScrollPhysics(),
//                 currentStep: _currentStep,
//                 onStepTapped: (step) => tapped(step),
//                 onStepContinue: continued,
//                 onStepCancel: cancel,
//                 controlsBuilder: (context, _) {
//                   return Container(
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       child: _currentStep == 0
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 TextButton(
//                                   style: TextButton.styleFrom(
//                                     padding: EdgeInsets.all(10),
//                                     backgroundColor: Colors.blue,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                   onPressed: () async {
//                                     if (_formKey.currentState!.validate()) {
//                                       if (_gnder != ' ') {
//                                         setState(() {
//                                           error = '';
//                                           continued();
//                                         });
//                                       } else {
//                                         setState(() {
//                                           error = "Select Gender";
//                                         });
//                                       }
//                                     }
//                                   },
//                                   child: Row(
//                                     children: const [
//                                       Text(
//                                         'Lanjut',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       Icon(
//                                         FeatherIcons.chevronRight,
//                                         color: Colors.white,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : _currentStep == 1
//                               ? Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {
//                                         cancel();
//                                       },
//                                       style: TextButton.styleFrom(
//                                         padding: const EdgeInsets.all(10),
//                                         backgroundColor: Colors.red,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         children: const [
//                                           Icon(
//                                             FeatherIcons.chevronLeft,
//                                             color: Colors.white,
//                                           ),
//                                           Text(
//                                             'Kembali',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     TextButton(
//                                       style: TextButton.styleFrom(
//                                         padding: EdgeInsets.all(10),
//                                         backgroundColor: Colors.blue,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                         ),
//                                       ),
//                                       onPressed: () async {
//                                         if (selectedIndex != -1) {
//                                           error2 = ' ';
//                                           continued();
//                                         } else
//                                           setState(() {
//                                             error2 = 'Pilih Aktifitas Anda';
//                                           });
//                                       },
//                                       child: Row(
//                                         children: const [
//                                           Text(
//                                             'Lanjut',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                           Icon(
//                                             FeatherIcons.chevronRight,
//                                             color: Colors.white,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               : _currentStep == 2
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         TextButton(
//                                           onPressed: () {
//                                             cancel();
//                                           },
//                                           style: TextButton.styleFrom(
//                                             padding: const EdgeInsets.all(10),
//                                             backgroundColor: Colors.red,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             children: const [
//                                               Icon(
//                                                 FeatherIcons.chevronLeft,
//                                                 color: Colors.white,
//                                               ),
//                                               Text(
//                                                 'Kembali',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         TextButton(
//                                           style: TextButton.styleFrom(
//                                             padding: EdgeInsets.all(10),
//                                             backgroundColor: Colors.blue,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                             ),
//                                           ),
//                                           onPressed: () async {
//                                             if (selectedIndexGoal != -1) {
//                                               setState(() {
//                                                 error3 = '';
//                                                 continued();
//                                               });
//                                             } else {
//                                               setState(() {
//                                                 error3 =
//                                                     'Pilih Pencapian Target Anda';
//                                               });
//                                             }
//                                           },
//                                           child: Row(
//                                             children: const [
//                                               Text(
//                                                 'Lanjut',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                               Icon(
//                                                 FeatherIcons.chevronRight,
//                                                 color: Colors.white,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : _currentStep == 3
//                                       ? Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 cancel();
//                                               },
//                                               style: TextButton.styleFrom(
//                                                 padding: EdgeInsets.all(10),
//                                                 backgroundColor: Colors.red,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10.0),
//                                                 ),
//                                               ),
//                                               child: Row(
//                                                 children: const [
//                                                   Icon(
//                                                     FeatherIcons.chevronLeft,
//                                                     color: Colors.white,
//                                                   ),
//                                                   Text(
//                                                     'Kembali',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             TextButton(
//                                                 style: TextButton.styleFrom(
//                                                   padding: EdgeInsets.all(10),
//                                                   backgroundColor: Colors.blue,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0),
//                                                   ),
//                                                 ),
//                                                 onPressed: () async {
//                                                   handleUpdateData();
//                                                 },
//                                                 child: !loading
//                                                     ? Row(
//                                                         children: const [
//                                                           Text(
//                                                             'Simpan',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 3,
//                                                           ),
//                                                           Icon(
//                                                             Icons.upload,
//                                                             color: Colors.white,
//                                                           ),
//                                                         ],
//                                                       )
//                                                     : const Center(
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .white),
//                                                       )),
//                                           ],
//                                         )
//                                       : TextButton(
//                                           onPressed: () {
//                                             cancel();
//                                           },
//                                           style: TextButton.styleFrom(
//                                             padding: EdgeInsets.all(10),
//                                             backgroundColor: Colors.red,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             children: const [
//                                               Icon(
//                                                 FeatherIcons.chevronLeft,
//                                                 color: Colors.white,
//                                               ),
//                                               Text(
//                                                 'Kembali',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ],
//                                           ),
//                                         ));
//                 },
//                 steps: <Step>[
//                   Step(
//                     title: Text(_currentStep == 0 ? "Info Pengguna" : ""),
//                     content: Container(
//                       width: size.width * .9,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                       ),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextFieldContainer(
//                                 child: RoundedInputField(
//                                   validator: NameValidator.validate,
//                                   onChanged: (value) {
//                                     setState(() => nama = value);
//                                   },
//                                   textValue: nama,
//                                   hintText: "Nama",
//                                   icon: Icons.person,
//                                   keyboardType: TextInputType.name,
//                                 ),
//                               ),
//                               // age
//                               TextFieldContainer(
//                                 child: RoundedInputField(
//                                   validator: AgeValidator.validate,
//                                   textValue: age.toString(),
//                                   onChanged: (value) {
//                                     setState(() => !value.isEmpty
//                                         ? age = int.parse(value)
//                                         : age = 0);
//                                   },
//                                   hintText: "Umur",
//                                   icon: Icons.assignment_ind,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                               ),
//                               // weight

//                               TextFieldContainer(
//                                 child: RoundedInputField(
//                                   validator: WeightValidator.validate,
//                                   textValue: weight.toString(),
//                                   onChanged: (value) {
//                                     setState(() => !value.isEmpty
//                                         ? weight = int.parse(value)
//                                         : weight = 0);
//                                   },
//                                   hintText: "Berat Badan dalam kg",
//                                   icon: Icons.assignment,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                               ),
//                               // height

//                               TextFieldContainer(
//                                 child: RoundedInputField(
//                                   hintText: "tinggi badan dalam cm",
//                                   textValue: height.toString(),
//                                   validator: HeightValidator.validate,
//                                   onChanged: (value) {
//                                     setState(() => !value.isEmpty
//                                         ? height = int.parse(value)
//                                         : height = 0);
//                                   },
//                                   icon: Icons.accessibility,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Container(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Row(
//                                         children: <Widget>[
//                                           Radio(
//                                             value: "Male",
//                                             groupValue: _gnder,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 _gnder = value as String;
//                                               });
//                                             },
//                                             activeColor: activeColor,
//                                           ),
//                                           const Text(
//                                             "Pria",
//                                             style: TextStyle(
//                                                 color: Colors.black87,
//                                                 fontSize: 18),
//                                           )
//                                         ],
//                                       )),
//                                   Container(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Row(
//                                         children: <Widget>[
//                                           Radio(
//                                             value: "Female",
//                                             groupValue: _gnder,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 _gnder = value as String;
//                                               });
//                                             },
//                                             activeColor: activeColor,
//                                           ),
//                                           const Text(
//                                             "Wanita",
//                                             style: TextStyle(
//                                                 color: Colors.black87,
//                                                 fontSize: 18),
//                                           )
//                                         ],
//                                       )),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   error,
//                                   style: const TextStyle(
//                                       color: Colors.red, fontSize: 14.0),
//                                 ),
//                               ),
//                             ]),
//                       ),
//                     ),
//                     isActive: _currentStep >= 0,
//                     state: _currentStep >= 0
//                         ? StepState.complete
//                         : StepState.disabled,
//                   ),
//                   Step(
//                     title: Text(_currentStep == 1 ? "Aktifitas Fisik" : ""),
//                     content: Container(
//                       width: size.width * .9,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 padding: const EdgeInsets.all(10.0),
//                                 width: size.width * 0.8,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: _activites
//                                       .map((e) => outLinedRadionButton(
//                                           e.text,
//                                           e.svg,
//                                           inactiveColor,
//                                           size.width * 0.75,
//                                           _activites.indexOf(e),
//                                           size.height * 0.13))
//                                       .toList(),
//                                 ),
//                               ),
//                               Text(
//                                 error2,
//                                 style: TextStyle(
//                                     color: Colors.red, fontSize: 14.0),
//                               ),
//                             ]),
//                       ),
//                     ),
//                     isActive: _currentStep >= 0,
//                     state: _currentStep >= 1
//                         ? StepState.complete
//                         : StepState.disabled,
//                   ),
//                   Step(
//                     title: Text(_currentStep == 2 ? "Target Pencapaian" : ""),
//                     content: Container(
//                       width: size.width * .85,
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.all(10.0),
//                                 width: size.width * 0.9,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: _goals
//                                       .map((e) => outLinedRadionButtonGoal(
//                                           e.text,
//                                           e.svg,
//                                           inactiveColor,
//                                           size.width * 0.8,
//                                           _goals.indexOf(e),
//                                           size.height * 0.15))
//                                       .toList(),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   error3,
//                                   style: TextStyle(
//                                       color: Colors.red, fontSize: 14.0),
//                                 ),
//                               ),
//                             ]),
//                       ),
//                     ),
//                     isActive: _currentStep >= 0,
//                     state: _currentStep >= 2
//                         ? StepState.complete
//                         : StepState.disabled,
//                   ),
//                   Step(
//                     title: Text(_currentStep == 3 ? "Riwayat Sakit" : ""),
//                     content: Container(
//                       width: size.width * .9,
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white,
//                       ),
//                       child: sb.isLoading == true
//                           ? Center(
//                               child: LoadingAnimationWidget.twistingDots(
//                                   leftDotColor: Colors.blue,
//                                   rightDotColor: Colors.yellow,
//                                   size: 50))
//                           : Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   constraints: BoxConstraints(
//                                     minHeight: 300,
//                                   ),
//                                   child: Center(
//                                     child: MultiSelectChipField<String?>(
//                                       initialValue: _penyakit,
//                                       items: sb.dataPenyakit!.data!
//                                           .map((sakit) =>
//                                               MultiSelectItem<String?>(
//                                                   sakit.nama, sakit.nama!))
//                                           .toList(),
//                                       scroll: false,
//                                       showHeader: false,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.transparent,
//                                             width: 0),
//                                       ),
//                                       selectedChipColor:
//                                           Colors.blue.withOpacity(0.5),
//                                       selectedTextStyle:
//                                           TextStyle(color: Colors.blue[800]),
//                                       onTap: (values) {
//                                         // _selectedAnimals4 = values;
//                                         _penyakit = values;
//                                         print("isi" + json.encode(_penyakit));
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     error4,
//                                     style: const TextStyle(
//                                         color: Colors.red, fontSize: 14.0),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     ),
//                     isActive: _currentStep >= 0,
//                     state: _currentStep >= 3
//                         ? StepState.complete
//                         : StepState.disabled,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.list),
//       //   onPressed: switchStepsType,
//       // ),
//     );
//   }

//   // switchStepsType() {
//   //   setState(() => stepperType == StepperType.vertical
//   //       ? stepperType = StepperType.horizontal
//   //       : stepperType = StepperType.vertical);
//   // }

//   tapped(int step) {
//     setState(() => _currentStep = step);
//   }

//   continued() {
//     _currentStep < 3 ? setState(() => _currentStep += 1) : null;
//   }

//   cancel() {
//     _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
//   }

//   Widget outLinedRadionButton(String text, String svg, Color txtColor,
//       double width, int index, double height) {
//     return Container(
//         padding: EdgeInsets.all(10.0),
//         height: height,
//         width: width,
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: TextButton(
//                 style: TextButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   side: BorderSide(
//                       width: 4,
//                       color:
//                           selectedIndex == index ? activeColor : inactiveColor),
//                 ),
//                 onPressed: () => changeIndex(index),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SvgPicture.asset(
//                       svg,
//                       height: height * 0.6,
//                     ),
//                     Text(
//                       text,
//                       overflow: TextOverflow.visible,
//                     )
//                   ],
//                 ))));
//   }

//   Widget outLinedRadionButtonGoal(String text, String svg, Color txtColor,
//       double width, int index, double height) {
//     return Container(
//         padding: EdgeInsets.all(10.0),
//         height: height,
//         width: width,
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: TextButton(
//                 style: TextButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   side: BorderSide(
//                       width: 4,
//                       color: selectedIndexGoal == index
//                           ? activeColor
//                           : inactiveColor),
//                 ),
//                 onPressed: () => changeIndexGoal(index),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     SvgPicture.asset(
//                       svg,
//                       height: height * 0.6,
//                     ),
//                     Expanded(
//                         child: Center(
//                             child: Text(
//                       text,
//                       textAlign: TextAlign.center,
//                     )))
//                   ],
//                 ))));
//   }

//   void changeIndex(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   void changeIndexGoal(int index) {
//     setState(() {
//       selectedIndexGoal = index;
//     });
//   }
// }

// class Activity {
//   final String text, svg;

//   Activity(this.text, this.svg);
// }

// class Goal {
//   final String text, svg;

//   Goal(this.text, this.svg);
// }
