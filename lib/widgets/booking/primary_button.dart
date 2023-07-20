import 'package:diet_penyakit/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  // Our primary button widget [to be reused]
  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;

  PrimaryButton({Key? key, this.text, this.onPressed, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(50.0),
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
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text!,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
        ),
      ),
    );
  }
}
