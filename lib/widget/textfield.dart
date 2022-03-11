import 'package:flutter/material.dart';

class TF extends StatelessWidget {
  TF(
      {  this.controller,
       this.hintText,
       this.prefixIcon,
       this.isPassword,
       this.readOnly,
       this.keyboardType,
       this.padding,
       this.margin,
       this.height,
       this.inputBorder});

  final TextEditingController? controller;
  final String? hintText;
  final Icon? prefixIcon;
  final bool? isPassword;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final InputBorder? inputBorder;
  final double? height;


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      obscureText: isPassword ?? false,
      style: TextStyle(fontSize: 15, ),
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: inputBorder?? OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle:TextStyle(fontSize: 15, ),
          border: inputBorder ?? InputBorder.none,
          focusedBorder: inputBorder ?? InputBorder.none,
          filled: true),
    );
  }
}

