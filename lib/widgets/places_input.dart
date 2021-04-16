import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/model/place.dart';
import 'package:places_app/screens/map_screen.dart';

class PlacesInput extends StatefulWidget {
  Function setPlace;
  PlacesInput(this.setPlace);
  @override
  _PlacesInputState createState() => _PlacesInputState();
}

class _PlacesInputState extends State<PlacesInput> {
  String _mapImageUrl;

  Future<void> _getSelectedLocation() async {
    final currentLoc = await Location().getLocation();
    final LatLng selectedLoc =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                  placeLocation: PlaceLocation(
                      lat: currentLoc.latitude, long: currentLoc.longitude),
                )));
    if (selectedLoc == null) return;
    final imgUrl =
        LocationHelper.getMapImage(selectedLoc.latitude, selectedLoc.longitude);
    setState(() {
      _mapImageUrl = imgUrl;
    });
    // print('selectedLoc.latitude${selectedLoc.latitude}');
    widget.setPlace(selectedLoc.latitude, selectedLoc.longitude);
  }

  Future<void> _getCurrentLocation() async {
    final currentLocData = await Location().getLocation();
    final mapImageUrl = LocationHelper.getMapImage(
        currentLocData.latitude, currentLocData.longitude);
    setState(() {
      _mapImageUrl = mapImageUrl;
    });
    widget.setPlace(currentLocData.latitude, currentLocData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          height: 200,
          width: double.infinity,
          child: _mapImageUrl == null
              ? Text(
                  'No location selected',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _mapImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getSelectedLocation,
                icon: Icon(Icons.add_location_rounded),
                label: Text(
                  'Select location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.location_pin),
                label: Text(
                  'Set current location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        )
      ],
    );
  }
}
