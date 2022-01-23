import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony_0/home.dart';
import 'dart:async';
import 'dart:convert';
import 'api.dart';

Future<Album> createAccount(
    String title, String userId, String userMail) async {
  final response = await http.post(
    Uri.parse('http://samirsuper.pythonanywhere.com/ok'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': title,
      "password": userId,
      'usermail': userMail,
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

class Album {
  final String title;
  final String userId;
  final String userMail;
  Album({required this.userId, required this.title, required this.userMail});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        title: json['name'], userId: json['password'], userMail: json['mail']);
  }
}

class NewAccount extends StatefulWidget {
  const NewAccount({Key? key}) : super(key: key);

  @override
  _NewAccountState createState() {
    return _NewAccountState();
  }
}

class _NewAccountState extends State<NewAccount> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllers = TextEditingController();
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controllermail = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Account'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: buildColumn(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controllermail,
          decoration: const InputDecoration(hintText: 'Enter you mail '),
        ),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter you name '),
        ),
        TextField(
          controller: _controllers,
          decoration: const InputDecoration(hintText: 'Enter password'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
            setState(
              () {
                _futureAlbum = createAccount(
                    _controller.text, _controllers.text, _controllermail.text);
              },
            );
          },
          child: const Text('login'),
        ),
        Container(
          padding: EdgeInsetsDirectional.all(23),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [Text('smiar')],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
