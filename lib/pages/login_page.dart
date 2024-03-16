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

  void _sendToken(String token) {
    // Utilisez la valeur du token ici
    print('Token: $token');
    // Vous pouvez implémenter ici la logique pour envoyer le token.
  }
}

Future<void> _launchInWebView() async {
  if (!await launchUrl(_url, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $_url');
  }
}
