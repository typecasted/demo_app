import 'package:demo_app/utils/constants.dart';
import 'package:demo_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldLoginScreen extends StatefulWidget {
  const TextFieldLoginScreen({
    // Key key,
    required this.hint,
    required this.icon,
    required this.textInputType,
    required this.isPass, required this.controller,
  }) : super();

  final String hint;
  final IconData icon;
  final TextInputType textInputType;
  final bool isPass;
  final TextEditingController controller;

  @override
  _TextFieldLoginScreenState createState() => _TextFieldLoginScreenState();
}

class _TextFieldLoginScreenState extends State<TextFieldLoginScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SC().h(context) * 0.01, horizontal: SC().w(context) * 0.06),
      child: TextField(
        style: textStyle1.copyWith(fontSize: SC().h(context) * 0.02),
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.isPass? !isVisible : isVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            size: SC().h(context) * 0.03,
            color: Color(0xFF325084),
          ),
          suffixIcon: widget.isPass
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                    size: SC().h(context) * 0.03,
                    color: Color(0xFF325084),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
