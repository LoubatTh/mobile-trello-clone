import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(
    MaterialApp(
      home: MyLoginPage(),
    ),
  );
}
