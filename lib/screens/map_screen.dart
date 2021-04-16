import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;

  MapScreen(
      {this.isSelecting = false,
      this.placeLocation = const PlaceLocation(lat: 27.42, long: -121.56)});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _pickLocation(LatLng tappedLoc) {
    setState(() {
      _pickedLocation = tappedLoc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () => _pickedLocation == null
                    ? null
                    : Navigator.of(context).pop(_pickedLocation))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.placeLocation.lat, widget.placeLocation.long),
            zoom: 16),
        onTap: widget.isSelecting ? _pickLocation : null,
        markers: _pickedLocation == null && widget.isSelecting
            ? <Marker>{}
            : <Marker>{
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                          widget.placeLocation.lat, widget.placeLocation.long),
                ),
              },
      ),
    );
  }
}
