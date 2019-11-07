//Code by AVDISX
import 'package:flutter/material.dart';
import 'screen/contact_us.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MailSend(),
    );
  }
}
