// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:data_base/home.dart';
// import 'package:data_base/logics/appstate.dart';
// import 'package:data_base/logics/globals.dart';

import 'package:flutter/material.dart';

void main() async {
  // teams = await AppState.teams;
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data base App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
