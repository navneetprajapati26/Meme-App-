import 'package:flutter/material.dart';
import 'package:meme_app/util/btn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../provider/memeProvider.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../util/loding.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({Key? key}) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  Future<void> shareImage(String imageUrl) async {
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.png').create();
    final response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    await Share.shareFiles(
      [file.path],
      text: 'Check out this cool image!',
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Saved Memes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<MemeProvider>(builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.memelist.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: height * (0.7),
                    // width: width*(0.5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          value.memelist[index],
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: Loading());
                          },
                          //fit: BoxFit.fill,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Btn(
                          onPressed: () {
                            value.memelist.removeAt(index);
                            setState(() {});
                          },
                          btnName: "Delete"),
                      SizedBox(
                        width: 10,
                      ),
                      Btn(
                          onPressed: () {
                            shareImage(value.meme!.url!);
                          },
                          btnName: "Share"),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 2,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              );
            });
      }),
    );
  }
}
