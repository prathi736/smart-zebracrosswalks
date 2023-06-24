import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartzebra_crosswalks/pages/image_preview.dart';
import 'package:smartzebra_crosswalks/pages/upload_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future pickCamera() async {
    try {
      final XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxWidth: 330, maxHeight: 220);
      if (image == null) return;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreviewPage(image: image),
          ));
    } on PlatformException catch (e) {
      print("Failed to pick Image : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 500), () => showCustomDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCCa7e7fb),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 105.0),
            Image.asset(
              "assets/images/first_page.png",
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Choose Any One Option:",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 60.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadImage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xF21170ff),
                  fixedSize: const Size(306, 62),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                "Image",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffffff)),
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                pickCamera();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xF21170ff),
                  fixedSize: const Size(306, 62),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                "Camera",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffffff)),
              ),
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: 350,
            width: 310,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded),
                  iconSize: 35,
                ),
                Column(
                  children: [
                    const Text(
                      "Welcome To Smart Zebra CrossWalks!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xB3000000)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "This application will help you in detecting and identifying vehicles that have overlapped zebra crossings.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xB3000000)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xF21170ff),
                          fixedSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFffffff)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
