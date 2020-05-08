import 'dart:async';
import 'package:flutter/material.dart';
import 'ParkingSpace.dart';
import 'Services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Parkering> futureParkering;

  @override
  void initState() {
    super.initState();
    futureParkering = Services.fetchParkering();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Parkering>(
            future: futureParkering,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.features[0].geometry.coordinates[2]
                    .toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
