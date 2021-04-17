import 'package:http/http.dart' as http;

import 'dart:convert';
import './key.dart';

const String GOOGLE_API_KEY = key;

class LocationHelper {
  static String getMapImage(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getLocationAddress(
      double latitude, double longitude) async {
    print('$latitude,$longitude');
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
