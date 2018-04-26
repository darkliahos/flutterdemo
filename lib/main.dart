import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Game> fetchGame() async {
  final response = await http.get('http://localhost:50566/api/games/Random');
  final jsonResponse = json.decode(response.body);
  return Game.fromJson(jsonResponse);
}

class Game{
        final String title;
        final String platform;
        final String genre;

        Game({this.title, this.platform, this.genre});

    factory Game.fromJson(Map<String, dynamic> json){
      return new Game(
        title: json['Title'],
        platform: json['Platform'],
        genre: json['Genre']
      );
    }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Get me a random game'),
        ),
        body: new Center(
          child: new FutureBuilder<Game>(
            future: fetchGame(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
