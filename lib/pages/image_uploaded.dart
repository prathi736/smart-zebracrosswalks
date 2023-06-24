import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartzebra_crosswalks/pages/image_info.dart';

class ImageUploadedPage extends StatefulWidget {
  List<XFile> imgList;
  ImageUploadedPage({Key? key, required this.imgList}) : super(key: key);

  @override
  State<ImageUploadedPage> createState() => _ImageUploadedPageState();
}

class _ImageUploadedPageState extends State<ImageUploadedPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCCa7e7fb),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Container(
              height: 460,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.27,
                ),
                padding: EdgeInsets.fromLTRB(20, 0, 25, 10),
                itemBuilder: (context, index) {
                  return Container(
                    child: Stack(
                      children: [
                        Image.file(File(widget.imgList[index].path)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.imgList.removeAt(index);
                            });
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close_rounded, size: 20),
                            backgroundColor: Color(0xFFfa1111),
                            radius: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.imgList.length,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Upload Images(${widget.imgList.length}/10)",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.imgList.clear();
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
                    for (var element in widget.imgList) {
                      File temp = File(element.path);
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
                                  InfoImage(response: response.body),
                            ));
                      } else {
                        print(response.body);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: imgList.isEmpty
                      //     ? Color(0x801170ff)
                      //     : Color(0xF21170ff),
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
