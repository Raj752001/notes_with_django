import 'package:flutter/material.dart';
import 'package:noteswithdjango/create.dart';
import 'listNotes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Django Notes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
      const ListNotes()
//      const CreateNote()
      ,
      debugShowCheckedModeBanner: false,
    );
  }
}



