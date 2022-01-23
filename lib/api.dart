import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:matrimony_0/login.dart';

Future<Album> createAlbum(String title, String userId) async {
  final response = await http.post(
    Uri.parse('http://samirsuper.pythonanywhere.com/oks'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': title,
      "password": userId,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future fettchWpPosts() async {
  final response = await http.get(
      Uri.parse('http://samirsuper.pythonanywhere.com/profile'),
      headers: {"Accept": "application/json"});
  var convertedDatetoJson = jsonDecode(response.body);
  return convertedDatetoJson;
}

Future<Album> createAccount(String title, String userId) async {
  final response = await http.post(
    Uri.parse('http://samirsuper.pythonanywhere.com/ok'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': title,
      "password": userId,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
