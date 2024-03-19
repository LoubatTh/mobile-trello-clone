import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/services/user_helper.dart';
import 'package:app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
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
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  MyLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrellTech'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Étapes à suivre :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Étape 1 :',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                      text: ' Appuyez sur le bouton ci-dessous ',
                    ),
                    TextSpan(
                      text: '"Extract your Trello token"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' pour obtenir votre jeton Trello.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Étape 2 :',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                      text:
                          ' Suivre les étapes de connexion et accepter les autorisations.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Étape 3 :',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                      text:
                          ' Une fois arrivé sur la page avec le token, copiez-le et collez-le dans le champ ci-dessous.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Étape 4 :',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                      text:
                          ' Il ne vous reste plus qu\'à appuyer sur le bouton ',
                    ),
                    TextSpan(
                      text: '"Send Token"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' pour valider votre jeton.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _launchInWebView(),
              child: const Text('Extract your Trello token'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your token here',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool databaseFilled =
                        await _sendToken(_textController.text);
                    if (!databaseFilled) {
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erreur'),
                            content: const Text(
                                'Le token n\'a pas pu être envoyé. Veuillez réessayer.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
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

  Future<bool> _sendToken(String token) async {
    final dbHelper = DatabaseHelper.instance;

    await dbHelper.deleteDatabase();
    await dbHelper.fillDatabaseWithToken(token);
    print('print database : ');
    await dbHelper.printDatabaseColumns();
    await dbHelper.printDatabase();

    return await dbHelper.isDatabaseFilled();
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
