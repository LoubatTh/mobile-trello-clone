// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// final Uri _url = Uri.parse(
//     'https://trello.com/1/authorize?expiration=never&scope=read,write,account&response_type=token&key=fddd47f32d57f1779100f625dc67f2b6');

// void main() => runApp(
//       const MaterialApp(
//         home: Material(
//           child: Center(
//             child: ElevatedButton(
//               onPressed: _launchUrl,
//               child: Text('Connect with Trello account'),
//             ),
//           ),
//         ),
//       ),
//     );

// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $Uri');
//   }
//   print(closeInAppWebView());
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_scraper/web_scraper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final authUrl = Uri.parse(
      "https://trello.com/1/authorize?expiration=never&scope=read,write,account&response_type=token&key=fddd47f32d57f1779100f625dc67f2b6");
  final String redirectUrl = "https://trello.com/1/token/approve";
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification à Trello'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await openUrlAndScrape(authUrl, redirectUrl);
          },
          child: Text('Se connecter avec Trello'),
        ),
      ),
    );
  }

  Future<void> openUrlAndScrape(Uri url, String redirectUrl) async {
    print("uri = " + url.toString());
    if (await canLaunch(url.toString())) {
      await launch(url.toString(), forceSafariVC: false, forceWebView: false);
      print("ouverture lien");
      // Wait for the browser to be opened and then scrape data.
      await Future.delayed(Duration(seconds: 5)); // Adjust as needed.

      // Check if the current URL matches the specified redirect URL.
      print("get current url");
      if (await currentUrlMatches(redirectUrl)) {
        // Scrape data if the URL matches.
        print("debut scraping");
        await scrapeDataAndClose(redirectUrl);
        print("fermeture lien");
      }
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  Future<bool> currentUrlMatches(String expectedUrl) async {
    final currentUrl = await getCurrentUrl();
    return currentUrl == expectedUrl;
  }

  Future<String> getCurrentUrl() async {
    // You may need to use the appropriate method to retrieve the current URL.
    // For example, if you're using a web view, you can use the webview_flutter package.
    // Modify this method based on your specific implementation.
    return 'https://www.trello.com/1/token/approve'; // Placeholder URL, replace with the actual method.
  }

  Future<void> scrapeDataAndClose(String redirectUrl) async {
    final webScraper = WebScraper(redirectUrl);

    // Wait for the page to load.
    await Future.delayed(Duration(seconds: 3)); // Adjust as needed.

    if (await webScraper.loadWebPage('/')) {
      // Scrape the data you need.
      print("scrapped uri : " + webScraper.baseUrl.toString());
      print("scrapped text : " + webScraper.getPageContent().toString());
      final preElement = webScraper.getElement('.surface .content', ['pre']);
      final scrapedText = preElement;

      // Display or use the scraped data.
      print('Scraped Text: $scrapedText');

      // Close the window.
      navigatorKey.currentState?.pop();
    } else {
      print('Impossible de charger la page pour le scraping.');
    }
  }
}
