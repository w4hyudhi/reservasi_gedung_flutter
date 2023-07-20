import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color? color, textColor;
  final double? width;
  const RoundedButton({
    Key? key,
    this.text,
    @required this.press,
    this.color,
    this.textColor = Colors.white,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .08,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple, // warna latar belakang tombol
          onPrimary: Colors.white, // warna teks pada tombol
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // membuat tombol berbentuk bulat
          ),
          elevation: 5, // memberi efek bayangan pada tombol
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Tombol Keren',
            style: TextStyle(
              fontSize: 18.0, // ukuran teks pada tombol
              fontWeight: FontWeight.bold, // teks tebal
            ),
          ),
        ),
      ),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(50),
      //   child: FlatButton(
      //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      //     color: color,
      //     onPressed: press,
      //     child: Text(
      //       text!,
      //       style: TextStyle(color: textColor),
      //     ),
      //   ),
      // ),
    );
  }
}

class RoundButtonGoogle extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color? color, textColor;
  final double? width;
  const RoundButtonGoogle({
    Key? key,
    this.text,
    this.press,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .08,
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton.icon(
          onPressed: press,
          icon: const Icon(Icons.login),
          label: const Text('Login dengan Google'),
        ));
  }
}
