import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldNameWidget extends StatelessWidget {
  const TextFieldNameWidget({Key? key, this.name = ''}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        name,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
