import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/provider/memeProvider.dart';
import 'package:meme_app/screens/saveScreen.dart';
import 'package:meme_app/util/btn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
  void initState() {
    final memeProvider = Provider.of<MemeProvider>(context, listen: false);
    setState(() {
      memeProvider.getMeme();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Memes",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SaveScreen()));
                  },
                  child: Text(
                    "Saved Memes",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Consumer<MemeProvider>(builder: (context, value, child) {
              print(value.meme!.author);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * (0.7),
                    // width: width*(0.6),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          value.meme!.url!,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: SizedBox(
                              height: 400,
                              width: 400,
                            ));
                          },
                          //fit: BoxFit.fill,
                        )),
                  ),
                ],
              );
            }),
          ),
        ),
        bottomNavigationBar:
            Consumer<MemeProvider>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Btn(
                  onPressed: () {
                    value.addMemeUrlInList();
                  },
                  btnName: "Save"),
              SizedBox(width: 10,),
              Btn(
                  onPressed: () {
                    shareImage(value.meme!.url!);
                  },
                  btnName: "Share"),
              SizedBox(width: 10,),
              Btn(
                  onPressed: () {
                    value.getMeme();
                  },
                  btnName: "Next"),
            ],
          );
        }));
  }
}
