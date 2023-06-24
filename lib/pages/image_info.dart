import 'dart:convert';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoImage extends StatefulWidget {
  dynamic response;
  InfoImage({Key? key, required this.response}) : super(key: key);

  @override
  State<InfoImage> createState() => _InfoImageState();
}

class _InfoImageState extends State<InfoImage> {
  @override
  Material build(BuildContext context) {
    json.decode(widget.response)['image'];
    // Uint8List byteConversion = await temp.readAsBytes();
    var b64decoded = base64.decode(json.decode(widget.response)['image']);
    return Material(
      color: const Color(0xCCa7e7fb),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 110.0),
            const Text(
              "Image of Vehicle(s)",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 30.0),
            CarouselSlider(
                items: [
                  Container(
                    height: 200,
                    width: 330,
                    child: Image.memory(b64decoded, fit: BoxFit.cover),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF1170ff),
                        ),
                        color: const Color(0xFFffffff),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2))),
                  ),
                ],
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                )),
            const SizedBox(height: 56.0),
            const Text(
              "Details of Vehicle(s)",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xB3000000)),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 210,
              width: 320,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF1170ff),
                  ),
                  color: const Color(0xFFfbfbfb),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    // padding: const EdgeInsets.fromLTRB(15, 15, 20, 25),
                    padding: const EdgeInsets.fromLTRB(15, 30, 20, 30),
                    child: Text(
                      "Number Plate: ${json.decode(widget.response)['number'].toString()},",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF000000)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
              "Do you want to go back to first page?",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF000000)),
            ),
            TextButton(
              onPressed: () => showCustomDialog(context),
              child: const Text(
                "Click Here",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1170ff),
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: 220,
            width: 300,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 40),
                      child: const Text(
                        "Back To First Page",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xB3000000)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xF21170ff),
                              fixedSize: const Size(108, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFffffff)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xF21170ff),
                              fixedSize: const Size(165, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            "No, Stay Here",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFffffff)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
