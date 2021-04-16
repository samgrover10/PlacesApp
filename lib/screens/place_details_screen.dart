import 'package:flutter/material.dart';
import 'package:places_app/providers/Places.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const route = '/places-details';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<Places>(context, listen: false).getPlaceById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Hero(
                tag: id,
                child: Image.file(
                  place.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(place.location.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (ctx) => MapScreen(
                            placeLocation: place.location,
                            isSelecting: false,
                          )));
                },
                child: Text(
                  'Show on map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
          ],
        ));
  }
}
