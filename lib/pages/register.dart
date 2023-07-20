// import 'package:diet_penyakit/blocs/sign_in_bloc.dart';
// import 'package:diet_penyakit/pages/level.dart';
// import 'package:diet_penyakit/utils/next_screen.dart';
// import 'package:diet_penyakit/utils/validators.dart';
// import 'package:diet_penyakit/widgets/Background.dart';
// import 'package:diet_penyakit/widgets/Buttons.dart';
// import 'package:diet_penyakit/widgets/InputFeiled.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   String error = '';

//   late int age;

//   late int weight;

//   late int height;

//   late String _gnder = ' ';
//   Color activeColor = const Color(0xFF5B16D0);

//   handleUpdateData() async {
//     final sb = context.read<SignInBloc>();

//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState?.save();
//       await sb.updateUserProfile(age, weight, height, _gnder).then((value) {
//         nextScreen(context, Level());
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Background(
//         child: SingleChildScrollView(
//           child: Container(
//             height: size.height * .8,
//             width: size.width * .85,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.white,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     // Diet Info
//                     Text(
//                       "Enter Your Health Info ",
//                       style: TextStyle(
//                         color: Colors.blue[600],
//                         fontSize: 28,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     // age
//                     TextFieldContainer(
//                       child: RoundedInputField(
//                         validator: AgeValidator.validate,
//                         onChanged: (value) {
//                           setState(() => !value.isEmpty
//                               ? age = int.parse(value)
//                               : age = 0);
//                         },
//                         hintText: "Age",
//                         icon: Icons.assignment_ind,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     // weight

//                     TextFieldContainer(
//                       child: RoundedInputField(
//                         validator: WeightValidator.validate,
//                         onChanged: (value) {
//                           setState(() => !value.isEmpty
//                               ? weight = int.parse(value)
//                               : weight = 0);
//                         },
//                         hintText: "Weight in Kg",
//                         icon: Icons.assignment,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     // height

//                     TextFieldContainer(
//                       child: RoundedInputField(
//                         hintText: "Height in CM",
//                         validator: HeightValidator.validate,
//                         onChanged: (value) {
//                           setState(() => !value.isEmpty
//                               ? height = int.parse(value)
//                               : height = 0);
//                         },
//                         icon: Icons.accessibility,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                             padding: const EdgeInsets.all(10),
//                             child: Row(
//                               children: <Widget>[
//                                 Radio(
//                                   value: "Male",
//                                   groupValue: _gnder,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _gnder = value as String;
//                                     });
//                                   },
//                                   activeColor: activeColor,
//                                 ),
//                                 const Text(
//                                   "Male",
//                                   style: TextStyle(
//                                       color: Colors.black87, fontSize: 18),
//                                 )
//                               ],
//                             )),
//                         Container(
//                             padding: const EdgeInsets.all(10),
//                             child: Row(
//                               children: <Widget>[
//                                 Radio(
//                                   value: "Female",
//                                   groupValue: _gnder,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _gnder = value as String;
//                                     });
//                                   },
//                                   activeColor: activeColor,
//                                 ),
//                                 const Text(
//                                   "Female",
//                                   style: TextStyle(
//                                       color: Colors.black87, fontSize: 18),
//                                 )
//                               ],
//                             )),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         error,
//                         style:
//                             const TextStyle(color: Colors.red, fontSize: 14.0),
//                       ),
//                     ),

//                     //submit button
//                     RoundedButton(
//                       width: size.width * .6,
//                       text: "Next",
//                       color: const Color.fromRGBO(49, 39, 79, 1),
//                       press: () async {
//                         if (_formKey.currentState!.validate()) {
//                           if (_gnder != ' ') {
//                             handleUpdateData();
//                           } else {
//                             setState(() {
//                               error = "Select Gender";
//                             });
//                           }
//                         }
//                       },
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
