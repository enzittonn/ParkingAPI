import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mapsketch/ParkingSpace.dart';


void main() {
  runApp(MyApp());
}

Future<ParkingSpace> fetchParkingSpace() async {
  final response = await http.get('https://openparking.stockholm.se/LTF-Tolken/v1/pbuss/within?radius=100&lat=59.32784&lng=18.05306&outputFormat=json&apiKey=c9e27b4b-e374-41b5-b741-00b90cbe2d97');

  if (response == 200) {
    return ParkingSpace.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch the data!');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Karta'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<ParkingSpace> futureParkingSpace;

  @override
  void initState() {
    super.initState();
    futureParkingSpace = fetchParkingSpace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(59.3293, 18.0686),
              zoom: 12.0,
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
