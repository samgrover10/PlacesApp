import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/model/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place getPlaceById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(String title, File imgFile, PlaceLocation pickedLoc) async {
    final address =
        await LocationHelper.getLocationAddress(pickedLoc.lat, pickedLoc.long);
    final updatedLoc = PlaceLocation(
        lat: pickedLoc.lat, long: pickedLoc.long, address: address);
    Place place = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLoc,
        image: imgFile);
    _items.add(place);
    notifyListeners();
    DBHelper.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.lat,
      'long': place.location.long,
      'address': place.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final listData = await DBHelper.getData('places');

    _items = listData
        .map((place) => Place(
            id: place['id'],
            image: File(place['image']),
            title: place['title'],
            location: PlaceLocation(
                lat: place['lat'],
                long: place['long'],
                address: place['address'])))
        .toList();
    notifyListeners();
  }
}
