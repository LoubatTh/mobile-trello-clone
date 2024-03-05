import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/src/response.dart';
import 'package:oauth1/oauth1.dart' as oauth1;

void main() {
  final oauth1.Platform platform = oauth1.Platform(
      'https://trello.com/1/OAuthGetRequestToken', // temporary credentials request
      'https://trello.com/1/OAuthAuthorizeToken', // resource owner authorization
      'https://trello.com/1/OAuthGetAccessToken', // token credentials request
      oauth1.SignatureMethods.hmacSha1 // signature method
      );

  // define client credentials (consumer keys)
  String apiKey = dotenv.env["API_KEY"]!;
  String apiSecret = dotenv.env["API_SECRET"]!;
  final oauth1.ClientCredentials clientCredentials =
      oauth1.ClientCredentials(apiKey, apiSecret);

  // create Authorization object with client credentials and platform definition
  final oauth1.Authorization auth =
      oauth1.Authorization(clientCredentials, platform);

  // request temporary credentials (request tokens)
  auth
      .requestTemporaryCredentials('oob')
      .then((oauth1.AuthorizationResponse res) {
    // redirect to authorization page
    print('Open with your browser:'
        '${auth.getResourceOwnerAuthorizationURI(res.credentials.token)}');

    // get verifier (PIN)
    stdout.write('PIN: ');
    final String verifier = stdin.readLineSync() ?? '';

    // request token credentials (access tokens)
    return auth.requestTokenCredentials(res.credentials, verifier);
  }).then((oauth1.AuthorizationResponse res) {
    // yeah, you got token credentials
    // create Client object
    final oauth1.Client client = oauth1.Client(
        platform.signatureMethod, clientCredentials, res.credentials);

    // now you can access to protected resources via client
    // client
    //     .get(Uri.parse(
    //         'https://api.twitter.com/1.1/statuses/home_timeline.json?count=1'))
    //     .then((Response res) {
    //   print(res.body);
    // });

    // NOTE: you can get optional values from AuthorizationResponse object
    print('Your screen name is ' + res.optionalParameters['screen_name']!);
  });
}
