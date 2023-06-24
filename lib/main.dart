import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:smartzebra_crosswalks/pages/splash_page.dart";
import "pages/home_page.dart";
import 'pages/upload_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: SplashPage(),
      routes: {
        "/splash_page": (context) => const HomePage(),
        "/splash_page/upload_image": (context) => UploadImage(),
      },
    );
  }
}
