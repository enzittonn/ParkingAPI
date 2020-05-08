import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Parkering parkingSpaceFromJson(String str) =>
    Parkering.fromJson(json.decode(str));

String parkingSpaceToJson(Parkering data) => json.encode(data.toJson());

class Parkering {
  String type;
  int totalFeatures;
  List<Feature> features;
  Crs crs;

  Parkering({
    this.type,
    this.totalFeatures,
    this.features,
    this.crs,
  });

  factory Parkering.fromJson(Map<String, dynamic> json) => Parkering(
        type: json["type"],
        totalFeatures: json["totalFeatures"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        crs: Crs.fromJson(json["crs"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "totalFeatures": totalFeatures,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "crs": crs.toJson(),
      };
}

class Crs {
  String type;
  CrsProperties properties;

  Crs({
    this.type,
    this.properties,
  });

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        type: json["type"],
        properties: CrsProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
      };
}

class CrsProperties {
  String name;

  CrsProperties({
    this.name,
  });

  factory CrsProperties.fromJson(Map<String, dynamic> json) => CrsProperties(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Feature {
  String type;
  String id;
  Geometry geometry;
  String geometryName;
  FeatureProperties properties;

  Feature({
    this.type,
    this.id,
    this.geometry,
    this.geometryName,
    this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromJson(json["geometry"]),
        geometryName: json["geometry_name"],
        properties: FeatureProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "geometry": geometry.toJson(),
        "geometry_name": geometryName,
        "properties": properties.toJson(),
      };
}

class Geometry {
  String type;
  List<List<double>> coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class FeatureProperties {
  int fid;
  int featureObjectId;
  int featureVersionId;
  int extentNo;
  DateTime validFrom;
  int startTime;
  int endTime;
  String startWeekday;
  int maxHours;
  String citation;
  String streetName;
  String cityDistrict;
  String parkingDistrict;
  String address;
  String vfPlatsTyp;
  String otherInfo;
  String rdtUrl;
  int vfMeter;

  FeatureProperties({
    this.fid,
    this.featureObjectId,
    this.featureVersionId,
    this.extentNo,
    this.validFrom,
    this.startTime,
    this.endTime,
    this.startWeekday,
    this.maxHours,
    this.citation,
    this.streetName,
    this.cityDistrict,
    this.parkingDistrict,
    this.address,
    this.vfPlatsTyp,
    this.otherInfo,
    this.rdtUrl,
    this.vfMeter,
  });

  factory FeatureProperties.fromJson(Map<String, dynamic> json) =>
      FeatureProperties(
        fid: json["FID"],
        featureObjectId: json["FEATURE_OBJECT_ID"],
        featureVersionId: json["FEATURE_VERSION_ID"],
        extentNo: json["EXTENT_NO"],
        validFrom: DateTime.parse(json["VALID_FROM"]),
        startTime: json["START_TIME"],
        endTime: json["END_TIME"],
        startWeekday: json["START_WEEKDAY"],
        maxHours: json["MAX_HOURS"] == null ? null : json["MAX_HOURS"],
        citation: json["CITATION"],
        streetName: json["STREET_NAME"],
        cityDistrict: json["CITY_DISTRICT"],
        parkingDistrict: json["PARKING_DISTRICT"],
        address: json["ADDRESS"],
        vfPlatsTyp: json["VF_PLATS_TYP"],
        otherInfo: json["OTHER_INFO"],
        rdtUrl: json["RDT_URL"],
        vfMeter: json["VF_METER"] == null ? null : json["VF_METER"],
      );

  Map<String, dynamic> toJson() => {
        "FID": fid,
        "FEATURE_OBJECT_ID": featureObjectId,
        "FEATURE_VERSION_ID": featureVersionId,
        "EXTENT_NO": extentNo,
        "VALID_FROM": validFrom.toIso8601String(),
        "START_TIME": startTime,
        "END_TIME": endTime,
        "START_WEEKDAY": startWeekday,
        "MAX_HOURS": maxHours == null ? null : maxHours,
        "CITATION": citation,
        "STREET_NAME": streetName,
        "CITY_DISTRICT": cityDistrict,
        "PARKING_DISTRICT": parkingDistrict,
        "ADDRESS": address,
        "VF_PLATS_TYP": vfPlatsTyp,
        "OTHER_INFO": otherInfo,
        "RDT_URL": rdtUrl,
        "VF_METER": vfMeter == null ? null : vfMeter,
      };
}

Future<Parkering> fetchParkering() async {
  final response = await http.get(
      'https://openparking.stockholm.se/LTF-Tolken/v1/pbuss/within?radius=100&lat=59.32784&lng=18.05306&outputFormat=json&apiKey=c9e27b4b-e374-41b5-b741-00b90cbe2d97');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Parkering.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load parkering');
  }
}

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
    futureParkering = fetchParkering();
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
                return Text(snapshot.data.features[0].geometry.coordinates[0]
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
