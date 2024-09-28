import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_fonts/google_fonts.dart';

class TextfieldWidget extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final IconData? suffixIcon;
  final bool? obscureTextWidget;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TextfieldWidget(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      this.suffixIcon,
      this.obscureTextWidget,
      this.controller,
      this.validator});

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  late bool obscureText;
  final FocusNode _focusNode = FocusNode();
  bool color = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureTextWidget ?? false;

    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          color = true;
          setState(() {});
        } else {
          setState(() {
            color = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            focusNode: _focusNode,
            obscureText: obscureText,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              filled: true,
              suffixIcon: widget.obscureTextWidget == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: color ? Colors.orangeAccent : Colors.black,
                      ))
                  : null,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.nunito(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              focusColor: Colors.orangeAccent,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.white,
            )));
  }
}
