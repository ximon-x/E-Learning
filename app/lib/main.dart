import 'package:app/pages/layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iLearn',
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.blue[600],
          secondary: Colors.blue[600],
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),

          // ···
          titleLarge: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          bodyMedium: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),

          displaySmall: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const LandingPage(title: 'iLearn'),
    );
  }
}
