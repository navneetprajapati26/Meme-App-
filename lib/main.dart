import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meme_app/provider/memeProvider.dart';
import 'package:meme_app/screens/homeScreen.dart';
import 'package:meme_app/screens/saveScreen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemeProvider()),
      ],
      child: Builder(
        builder: (BuildContext context){
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
