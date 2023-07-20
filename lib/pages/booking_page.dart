import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:diet_penyakit/blocs/internet_bloc.dart';
import 'package:diet_penyakit/blocs/transaksi_bloc.dart';
import 'package:diet_penyakit/configs/configs.dart';
import 'package:diet_penyakit/pages/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final String ruangan_id;
  final String harga;
  const BookingScreen({Key? key, required this.ruangan_id, required this.harga})
      : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final formatter = new NumberFormat("#,###", 'ID');
  String startdate = '';
  String enddate = '';
  String _rangeCount = '';

  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  String _eventName = '';
  String _eventDescription = '';
  bool _isSaving = false;
  String total = '';
  String error = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        DateTime startDate = args.value.startDate;
        DateTime endDate = args.value.endDate ?? args.value.startDate;

        startdate = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)}';
        enddate =
            '${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';

        Duration difference = endDate.difference(startDate);
        int daysDifference = difference.inDays + 1;
        _rangeCount = daysDifference.toString();

        total = (widget.harga.toDouble() * daysDifference).toString();
      }
    });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );

    if (selectedTime != null && selectedTime != _startTime) {
      setState(() {
        _startTime = selectedTime;
      });
    }
  }

  handleUpdateData() async {
    final sb = context.read<TransaksiBloc>();
    final ib = context.read<InternetBloc>();
    setState(() => _isSaving = true);
    await ib.checkInternet();
    if (ib.checkInternet() == false) {
      setState(() {
        _isSaving = false;
        error = 'Koneksi internet bermasalah';
      });
      // openSnacbar(scaffoldKey, 'check your internet connection!');
    } else {
      sb
          .saveTransaksi(
        widget.ruangan_id,
        _eventName,
        _eventDescription,
        startdate,
        enddate,
        _startTime.format(context).toString(),
        _endTime.format(context).toString(),
        _rangeCount,
        widget.harga,
        total,
      )
          .then((value) {
        if (value != true) {
          // openSnacbar(scaffoldKey, 'something is wrong. please try again.');
          setState(() {
            _isSaving = false;
            error = 'Gagal menyimpan data';
          });
        } else {
          setState(() => _isSaving = false);
          openSnacbar(context, "order berhasil");
          Navigator.of(context).pop(true);
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );

    if (selectedTime != null && selectedTime != _endTime) {
      setState(() {
        _endTime = selectedTime;
      });
    }
  }

  Future<void> _saveBooking() async {
    if (_eventName.isEmpty || _eventDescription.isEmpty || startdate.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Gagal'),
            content: Text('Lengkapi data yang di perlukan'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
        context: context,
        builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.currency_exchange,
                        color: Theme.of(context).primaryColor,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(children: [
                      Text(
                        'Detail Booking',
                        style: GoogleFonts.inter(
                          fontSize: 26.0,
                          color: Color.fromRGBO(138, 150, 191, 1),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        _eventName,
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                          color: Color.fromRGBO(138, 150, 191, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tanggal:",
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              startdate,
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lama Acara:",
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _rangeCount + ' Hari',
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "harga gedung:",
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rp ${formatter.format(widget.harga.toDouble())}',
                              style: GoogleFonts.inter(
                                fontSize: 18.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL:",
                              style: GoogleFonts.inter(
                                fontSize: 24.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${formatter.format(total.toDouble())}',
                              style: GoogleFonts.inter(
                                fontSize: 24.0,
                                color: Color.fromRGBO(138, 150, 191, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ]),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(40.0),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(169, 176, 185, 0.42),
                                    spreadRadius: 0,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              handleUpdateData();
                            },
                            child: Container(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(40.0),
                              decoration: BoxDecoration(
                                color: Config.primaryColor,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(169, 176, 185, 0.42),
                                    spreadRadius: 0,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ));
    // setState(() {
    //   _isSaving = true;
    // });

    // // Simulasikan proses penyimpanan dengan delay selama 2 detik
    // await Future.delayed(Duration(seconds: 2));

    // // Setelah proses selesai, atur kembali variabel _isSaving menjadi false
    // setState(() {
    //   _isSaving = false;
    // });

    // Tambahkan logika penyimpanan atau tindakan lainnya di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Booking Tempat",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.access_time),
                                  title: Text('jam mulai'),
                                  subtitle:
                                      Text('${_startTime.format(context)}'),
                                  onTap: () {
                                    _selectStartTime(context);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.access_time),
                                  title: Text('jam selesai'),
                                  subtitle: Text('${_endTime.format(context)}'),
                                  onTap: () {
                                    _selectEndTime(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nama Kegiatan",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: Color.fromRGBO(138, 150, 191, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: ScreenUtil().setHeight(40.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 247, 249, 1),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(124, 124, 124, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _eventName = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Deskripsi Kegiatan",
                          style: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: Color.fromRGBO(138, 150, 191, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: ScreenUtil().setHeight(100.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 247, 249, 1),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextFormField(
                            maxLines: null,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromRGBO(124, 124, 124, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _eventDescription = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () async {
                  _saveBooking();
                },
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(40.0),
                  decoration: BoxDecoration(
                    color: Config.primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(169, 176, 185, 0.42),
                        spreadRadius: 0,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Center(
                    child: _isSaving
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Booking Tempat',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
