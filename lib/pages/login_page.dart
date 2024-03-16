import 'package:app/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse(
    'https://trello.com/1/authorize?expiration=never&scope=read,write,account&response_type=token&key=fddd47f32d57f1779100f625dc67f2b6');

class MyHomePage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  MyHomePage({super.key});

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
                  onPressed: () => _sendToken(_textController.text),
                  child: const Text('Send Token'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sendToken(String token) async {
    final dbHelper = DatabaseHelper.instance;
    final existingToken = await dbHelper.getFirstToken();
    if (existingToken == null) {
      // Créez la base de données si elle n'existe pas
      await dbHelper.insertToken(token);
    } else {
      // Remplacez le premier token s'il existe
      await dbHelper.deleteFirstToken();
      await dbHelper.insertToken(token);
    }
    var tokenBdd = await dbHelper.getFirstToken();
    print('Token: $token');
    print('Token base de données avec get : ' + tokenBdd!);
  }
}

Future<void> _launchInWebView() async {
  if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $_url');
  }
}
