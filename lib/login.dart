import 'package:flutter/material.dart';
import 'package:matrimony_0/api.dart';
import 'package:matrimony_0/create_account.dart';
import 'package:matrimony_0/home.dart';

class Album {
  final String title;
  final String userId;
  Album({required this.userId, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(title: json['name'], userId: json['password']);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllers = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
            setState(() {
              _futureAlbum = createAlbum(_controller.text, _controllers.text);
              print(_futureAlbum.toString());
            });
          },
          child: const Text('login'),
        ),
        Container(
          padding: EdgeInsetsDirectional.all(23),
        ),
        Divider(),
        Row(
          children: [
            Container(
              child: Text('Create new account'),
            ),
            Container(
              width: 100,
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => NewAccount()));
                  },
                  child: Text('Sing up')),
            )
          ],
        )
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              (snapshot.data!.title == 'samir')
                  ? ElevatedButton(
                      child: const Text('Open route'),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                    )
                  : Text('smiar')
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

// class SecondRoute extends StatelessWidget {
//   Future<Album>? _futureAlbum;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Welcome to new page'),
//         ),
//       ),
//     );
//   }

//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Column(
//             children: [
//               (snapshot.data!.title == 'samir')
//                   ? ElevatedButton(
//                       child: const Text('Open route'),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SecondRoute()),
//                         );
//                       },
//                     )
//                   : Text('smiar')
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
