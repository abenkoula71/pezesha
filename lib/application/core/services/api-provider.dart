import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

const publickey = '7ceadb6f0e3653f3e910d6ae9d435551';
const privatekey = 'bd5b3046e5684f9f7001b79e9779061d92e143b5';
final ts = DateTime.now().millisecondsSinceEpoch.toString();
final hash = generateMd5(ts + publickey + privatekey).toString();
const baseUrl = 'https://gateway.marvel.com';
final url = baseUrl + "/v1/public/characters";

class ApiProvider {
  hash() {
    return generateMd5("$ts$privatekey$publickey");
  }

  Future getMarvelCharacters() async {
    http.Response response = await http.get(
        Uri.parse('$url?&ts=$ts&limit=20&apikey=$publickey&hash=${hash()}'));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
