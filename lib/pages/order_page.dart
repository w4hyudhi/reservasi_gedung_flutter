// import 'package:diet_penyakit/blocs/internet_bloc.dart';
// import 'package:diet_penyakit/blocs/sawah_bloc.dart';
// import 'package:diet_penyakit/blocs/transaksi_bloc.dart';
// import 'package:diet_penyakit/pages/snacbar.dart';
// import 'package:diet_penyakit/pages/tambah_sawah.dart';
// import 'package:diet_penyakit/utils/next_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// import '../utils/color_resources.dart';
// import '../utils/dimensions.dart';
// import '../utils/styles.dart';
// import '../widgets/custom_snackbar.dart';
// import '../widgets/permission_dialog.dart';
// import 'package:provider/provider.dart';

// import 'add_sawah.dart';

// class OrderForm extends StatefulWidget {
//   final String bisnis_id;

//   const OrderForm({Key? key, required this.bisnis_id}) : super(key: key);
//   @override
//   _OrderFormState createState() => _OrderFormState();
// }

// class _OrderFormState extends State<OrderForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _dateController = TextEditingController();
//   String? _selectedAddress;
//   String? _selectedDate;
//   int _addressIndex = 1;
//   bool loading = false;
//   String error = '';
//   int? idsawah;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(milliseconds: 0)).then((value) {
//       context.read<SawahBloc>().getData();
//     });
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }

//   void _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 30)),
//     );

//     if (picked != null) {
//       setState(() {
//         _dateController.text = DateFormat('yyyy/MM/dd').format(picked);
//       });
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       handleUpdateData();
//       // _formKey.currentState!.save();
//       // Kirim data pemesanan ke server atau lakukan operasi lainnya.
//       print(
//           'Pemesanan sukses dengan tanggal $_selectedDate dan alamat $_selectedAddress');
//     }
//   }

//   handleUpdateData() async {
//     final sb = context.read<TransaksiBloc>();
//     final ib = context.read<InternetBloc>();
//     setState(() => loading = true);
//     await ib.checkInternet();
//     if (ib.checkInternet() == false) {
//       setState(() {
//         loading = false;
//         error = 'Koneksi internet bermasalah';
//       });
//       // openSnacbar(scaffoldKey, 'check your internet connection!');
//     } else {
//       sb
//           .saveTransaksi(
//         widget.bisnis_id,
//         idsawah.toString(),
//         _selectedDate!,
//       )
//           .then((value) {
//         if (value != true) {
//           // openSnacbar(scaffoldKey, 'something is wrong. please try again.');
//           setState(() {
//             loading = false;
//             error = 'Gagal menyimpan data';
//           });
//         } else {
//           setState(() => loading = false);
//           openSnacbar(context, "order berhasil");
//           Navigator.of(context).pop(true);
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sb = context.watch<SawahBloc>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Form Pemesanan'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Tanggal Pemesanan',
//                     suffixIcon: IconButton(
//                       onPressed: () => _selectDate(context),
//                       icon: Icon(Icons.calendar_today),
//                     ),
//                   ),
//                   controller: _dateController,
//                   readOnly: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Tanggal pemesanan tidak boleh kosong.';
//                     }
//                     _selectedDate = value;
//                   },
//                   // onSaved: (value) {

//                   // },
//                 ),
//                 SizedBox(height: 16),
//                 Column(children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: Dimensions.PADDING_SIZE_SMALL),
//                     child: Row(children: [
//                       Text('Alamat Sawah',
//                           style: rubikMedium.copyWith(
//                               fontSize: Dimensions.FONT_SIZE_LARGE)),
//                       Expanded(child: SizedBox()),
//                       TextButton.icon(
//                         onPressed: () => _checkPermission(),
//                         icon: Icon(Icons.add),
//                         label: Text('add', style: rubikRegular),
//                       ),
//                     ]),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     height: 60,
//                     child: sb.datasawah != null
//                         ? sb.datasawah!.dataSawah!.isNotEmpty
//                             ? ListView.builder(
//                                 physics: BouncingScrollPhysics(),
//                                 scrollDirection: Axis.horizontal,
//                                 padding: EdgeInsets.only(
//                                     left: Dimensions.PADDING_SIZE_SMALL),
//                                 itemCount: sb.datasawah!.dataSawah!.length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: EdgeInsets.only(
//                                         right: Dimensions.PADDING_SIZE_LARGE),
//                                     child: InkWell(
//                                       onTap: () async {
//                                         setState(() {
//                                           _addressIndex = index;
//                                           idsawah = sb
//                                               .datasawah!.dataSawah![index].id!;
//                                         });

//                                         showDialog(
//                                             context: context,
//                                             builder: (context) => Center(
//                                                     child: Container(
//                                                   height: 100,
//                                                   width: 100,
//                                                   decoration: BoxDecoration(
//                                                     color: Theme.of(context)
//                                                         .cardColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                   alignment: Alignment.center,
//                                                   child: CircularProgressIndicator(
//                                                       valueColor:
//                                                           AlwaysStoppedAnimation<
//                                                               Color>(Theme.of(
//                                                                   context)
//                                                               .primaryColor)),
//                                                 )),
//                                             barrierDismissible: false);

//                                         Navigator.pop(context);
//                                       },
//                                       child: Stack(children: [
//                                         Container(
//                                           height: 60,
//                                           width: 200,
//                                           decoration: BoxDecoration(
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.black
//                                                     .withOpacity(0.2),
//                                                 spreadRadius: 0,
//                                                 blurRadius: 1.5,
//                                                 offset: Offset(0, 0),
//                                               )
//                                             ],
//                                             color: index == _addressIndex
//                                                 ? Theme.of(context).cardColor
//                                                 : ColorResources
//                                                     .BACKGROUND_COLOR,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: index == _addressIndex
//                                                 ? Border.all(
//                                                     color: Theme.of(context)
//                                                         .primaryColor,
//                                                     width: 2)
//                                                 : null,
//                                           ),
//                                           child: Row(children: [
//                                             Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: Dimensions
//                                                       .PADDING_SIZE_EXTRA_SMALL),
//                                               child: Icon(
//                                                 Icons.list_alt_outlined,
//                                                 color: index == _addressIndex
//                                                     ? Theme.of(context)
//                                                         .primaryColor
//                                                     : Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1
//                                                         ?.color,
//                                                 size: 30,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Text(
//                                                         sb
//                                                             .datasawah!
//                                                             .dataSawah![index]
//                                                             .name!,
//                                                         style: rubikRegular
//                                                             .copyWith(
//                                                           fontSize: Dimensions
//                                                               .FONT_SIZE_SMALL,
//                                                           color: ColorResources
//                                                               .COLOR_GREY,
//                                                         )),
//                                                     Text(
//                                                         sb
//                                                             .datasawah!
//                                                             .dataSawah![index]
//                                                             .addres!,
//                                                         style: rubikRegular,
//                                                         maxLines: 1,
//                                                         overflow: TextOverflow
//                                                             .ellipsis),
//                                                   ]),
//                                             ),
//                                             index == _addressIndex
//                                                 ? Align(
//                                                     alignment:
//                                                         Alignment.topRight,
//                                                     child: Icon(
//                                                         Icons.check_circle,
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                   )
//                                                 : SizedBox(),
//                                           ]),
//                                         ),
//                                       ]),
//                                     ),
//                                   );
//                                 },
//                               )
//                             : Center(child: Text('no_address_available'))
//                         : Center(
//                             child: CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     Theme.of(context).primaryColor))),
//                   ),
//                   SizedBox(height: 20),
//                 ]),
//                 SizedBox(height: 32),
//                 Center(
//                   child: Center(
//                     child: ElevatedButton.icon(
//                       onPressed: idsawah == null ? null : _submitForm,
//                       icon: loading
//                           ? Container(
//                               width: 24,
//                               height: 24,
//                               padding: const EdgeInsets.all(2.0),
//                               child: const CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 3,
//                               ),
//                             )
//                           : const Icon(Icons.send),
//                       label: Text(
//                         'Order Combine',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.blue,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _checkPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.denied) {
//       showCustomSnackBar('you_have_to_allow', context);
//     } else if (permission == LocationPermission.deniedForever) {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => PermissionDialog());
//     } else {
//       nextScreen(context, TambahSawah());
//       ;
//     }
//   }
// }
