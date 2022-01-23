import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Homepage extends StatefulWidget {
  @override
  _State createState() => _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<Homepage> {
  int _selectedIndex = 0;
  //Map is basically a type of key/value pair in dart
  Map _countries = Map();

  void _getData() async {
    var url = 'http://samirsuper.pythonanywhere.com/profile';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() => _countries = jsonDecode(response.body));
      print(_countries['2']['image']);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      (_selectedIndex == 0)
          ? null
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => Whats()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        bottomNavigationBar: (BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "message"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: "interest"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          ],
        )),
        body: Container(
          child: Column(
            children: <Widget>[
              new Expanded(
                  child: new ListView.builder(
                itemCount: _countries.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = _countries.keys.elementAt(index);
                  return new Row(
                    children: <Widget>[
                      Card(
                        margin: const EdgeInsetsDirectional.all(20),
                        child: Row(
                          children: [
                            Container(
                                height: 200,
                                width: 130,
                                child: Image.network(
                                    "https://picsum.photos/id/237/200/300")),
                            Container(
                              color: Colors.white,
                              height: 200,
                              width: 220,
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 32, 5),
                                    width: 200,
                                    child: Text(
                                      "${_countries[key]['name']}",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 3, 10, 5),
                                    child: Text(_countries[key]['profession']),
                                  ),
                                  Container(
                                    width: 200,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 3, 10, 5),
                                    child: Text(_countries[key]['birth']),
                                  ),
                                  Container(
                                    width: 200,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 3, 10, 5),
                                    child: Text(_countries[key]['cast']),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            90, 25, 10, 5),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('interest'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ))
            ],
          ),
        ));
  }

  @override
  void initState() {
    _getData();
  }
}

class Whats extends StatelessWidget {
  const Whats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
