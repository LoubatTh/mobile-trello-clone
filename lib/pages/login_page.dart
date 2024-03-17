import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/services/user_helper.dart';
import 'package:app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrellTech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[900],
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _launchInWebView(),
              child: const Text('Extract your Trello token'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your token here',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _sendToken(_textController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: const Text('Send Token'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendToken(String token) async {
    final dbHelper = DatabaseHelper.instance;

    await dbHelper.deleteDatabase();
    await dbHelper.fillDatabaseWithToken(token);
    print('print database : ');
    await dbHelper.printDatabaseColumns();
    await dbHelper.printDatabase();
  }
}

Future<void> _launchInWebView() async {
  final apiurl = dotenv.env['API_URL'];
  final apikey = dotenv.env['API_KEY'];
  final _url = Uri.parse(
      '$apiurl/authorize?expiration=never&scope=read,write,account&response_type=token&key=$apikey');
  if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $_url');
  }
}
