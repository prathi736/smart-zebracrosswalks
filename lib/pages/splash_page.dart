import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartzebra_crosswalks/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xF21170ff),
      child: Column(
        children: [
          const SizedBox(height: 240.0),
          // Image.network(
          //   // "assets/images/app_icon.png",
          //   "https://i.postimg.cc/gjYMfq0f/Big-App-Icon.png",
          //   height: 280,
          //   width: 280,
          //   fit: BoxFit.cover,
          // ),
          CachedNetworkImage(
            imageUrl: 'https://i.postimg.cc/gjYMfq0f/Big-App-Icon.png',
            height: 280,
            width: 280,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 35.0),
          const Text(
            "Smart Zebra CrossWalks",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFFffffff)),
          ),
        ],
      ),
    );
  }
}
