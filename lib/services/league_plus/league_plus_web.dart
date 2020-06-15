import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaguePlusWeb{
  static final http.Client _client = http.Client();
  static String bearerToken;

  static Future authenticate() async {
    var body = json.encode({
        "username": "freeUser",
        "password": "freePassword"
    });

    var response = await _client.post('https://leagueplusapi.azurewebsites.net/api/authenticate',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: body);

    if(response == null || response.statusCode != 200){
      print('[${response.statusCode}] Couldnt Authenticate to LeaguePlus api');
      return null;
    }

    bearerToken = response.body.substring(1, response.body.length - 1);
    print('$bearerToken');
    return bearerToken;
  }
}