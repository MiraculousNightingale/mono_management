import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mono_management/resources/constants.dart';

class MonoManagementLogo extends StatelessWidget {
  const MonoManagementLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        applicationName,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
