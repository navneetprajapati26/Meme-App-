import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/provider/memeProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Consumer<MemeProvider>(builder: (context, value, child) {
            print(value.meme.author);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        value.meme.url!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: SizedBox(
                            height: 400,
                            width: 400,
                          ));
                        },
                        fit: BoxFit.fill,
                      )),
                ),
                CupertinoButton(
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.tealAccent,
                    ),
                    onPressed: () {
                      value.getMeme();
                    }),
                CupertinoButton(
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      value.addMemeUrlInList();
                    }),
                CupertinoButton(
                    child: Container(
                      height: 50,
                      width: 100,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      print(value.memelist);
                    })
              ],
            );
          }),
        ),
      ),
    );
  }
}
