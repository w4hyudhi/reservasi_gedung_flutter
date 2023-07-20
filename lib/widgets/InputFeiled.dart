import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  final Color? color;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final String? textValue;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final Color? iconColor, color, txtColor;
  // final FormFieldValidator? validator;
  // final String? Function(String?) validator;

  final String? Function(String?)? validator;
  final Function? onSubmitted;
  final TextInputType? keyboardType;
  final TextEditingController? controllerText;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.textValue,
    this.icon = Icons.person,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    required this.validator,
    this.iconColor = const Color(0xFF5B16D0),
    this.color,
    this.controllerText,
    this.txtColor = const Color(0xFF5B16D0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: txtColor,
      ),
      initialValue: textValue,
      controller: controllerText,
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.orange,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        icon: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  final FormFieldValidator? validator;
  final Function? onSubmitted;
  final String? hintText;

  final Color? color, txtColor, cursorColor;
  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.color,
    this.txtColor = const Color(0xFF5B16D0),
    this.cursorColor,
    this.onSubmitted,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: txtColor,
      ),
      validator: validator,
      initialValue: hintText,
      obscureText: true,
      onChanged: onChanged,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        hintText: hintText,
        icon: Icon(
          Icons.lock,
          color: color,
        ),
        suffixIcon: Icon(
          Icons.visibility,
          color: color,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
