import 'package:flutter/material.dart';



class ParkingSpace {
  String address;
  String vehicle_type;
  String city_district;
  int max_hour;
  String service_hour;


  ParkingSpace({this.address, this.vehicle_type, this.city_district, this.max_hour, this.service_hour});

  factory ParkingSpace.fromJson(Map<String, dynamic> json) {
    return ParkingSpace(
      address: json['address'],
      vehicle_type: json['vehicle_type'],
      city_district: json['city_district'],
      max_hour: json['max_hour'],
      service_hour: json['service_hour'],
    );
  }
}