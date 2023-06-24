import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartzebra_crosswalks/pages/image_uploaded.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImage extends StatefulWidget {
  UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;

  Future pickImage() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      print("Permission granted");
      try {
        final image = await ImagePicker().pickMultiImage();
        if (image.isEmpty) return;
        if (image.length < 11) {
          image.forEach((element) {
            imgList.add(element);
          });
        } else {
          for (int i = 0; i < 10; i++) {
            imgList.add(image[i]);
          }
        }

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageUploadedPage(
                imgList: imgList,
              ),
            ));
      } on PlatformException catch (e) {
        print("Failed to pick Image : $e");
      }
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.storage.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        print("Permission was granted");
      }
    }
  }

  List<XFile> imgList = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCCa7e7fb),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250.0),
            const Text(
              "Upload Images",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 100.0),
            Center(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Color(0xFF1170ff),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    pickImage();
                  },
                  icon: const Icon(Icons.upload_rounded),
                  iconSize: 70,
                  color: const Color(0xFFffffff),
                ),
              ),
            ),
            const SizedBox(height: 150.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xF21170ff),
                      fixedSize: const Size(107, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff)),
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: imgList.isEmpty
                          ? Color(0x801170ff)
                          : Color(0xF21170ff),
                      fixedSize: const Size(135, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xCCffffff)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
