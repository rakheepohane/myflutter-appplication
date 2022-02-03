import'package:flutter/material.dart';

import 'homepage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0,
          iconTheme:const IconThemeData(color: Colors.black),
          toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6,

        ),),



      routes: {
        "/": (context) =>HomePage(),
      },
    );

  }

}
