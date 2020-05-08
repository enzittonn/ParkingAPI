/*
import 'package:http/http.dart' as http;
import 'ParkingSpace.dart';

class Services {
  static const String url = 'https://openparking.stockholm.se/LTF-Tolken/v1/pbuss/within?radius=100&lat=59.32784&lng=18.05306&outputFormat=json&apiKey=c9e27b4b-e374-41b5-b741-00b90cbe2d97';

  static Future<List> getParkingSpace() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List parkingspaces = parkingSpaceFromJson(response.body);
        return parkingspaces;
      }
    } catch (e) {
      return List<Parkering>();
    }

  }
}*/
