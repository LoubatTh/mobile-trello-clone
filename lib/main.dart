import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(
    MaterialApp(
      title: 'TrellTech',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[900],
        ),
      ),
      home: MyLoginPage(),
    ),
  );
}
