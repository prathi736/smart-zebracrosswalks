import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartzebra_crosswalks/pages/image_analysis.dart';

class ImagePreviewPage extends StatefulWidget {
  final XFile image;

  const ImagePreviewPage({Key? key, required this.image}) : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCCa7e7fb),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 140),
            const Text(
              "Preview of Image",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 27),
            Container(
              // height: 220,
              // width: 330,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF1170ff),
                  ),
                  color: const Color(0xFFffffff),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  Image.file(
                    File(widget.image.path),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 220),
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
                  onPressed: () async {
                    List data = [];
                    File temp = File(widget.image.path);
                    Uint8List byteConversion = await temp.readAsBytes();
                    String b64encoded = base64.encode(byteConversion);
                    data.add(b64encoded);
                    final response = await http.post(
                        Uri.parse(
                            'https://a0b7-122-50-210-103.ngrok-free.app/predict'),
                        headers: {'Content-type': 'application/json'},
                        //encoding: e,
                        body: json.encode({"image": b64encoded}));
                    if (response.statusCode == 200) {
                      print('success');
                      print(json.decode(response.body)['number']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageAnalysis(response: response.body),
                          ));
                    } else {
                      print(response.body);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xF21170ff),
                      fixedSize: const Size(135, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff)),
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
