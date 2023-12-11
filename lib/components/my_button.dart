import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  final String name;
  VoidCallback onPressed;

  MyButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: HexColor('#98D0F8'),
      onPressed: onPressed,
      child: Text(name,
          style: GoogleFonts.tenorSans(
              fontWeight: FontWeight.w800, letterSpacing: 1)),
    );
  }
}
