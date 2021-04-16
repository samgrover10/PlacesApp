import 'package:flutter/material.dart';
import 'package:places_app/providers/Places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/widgets/places_item.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Places'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.route);
                })
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Places>(
                  builder: (_, placesData, __) => placesData.items.length <= 0
                      ? Center(
                          child: Text('No places added yet!'),
                        )
                      : ListView.builder(
                          itemCount: placesData.items.length,
                          itemBuilder: (_, index) => PlaceItem(
                              placesData.items[index].image,
                              placesData.items[index].title,
                              placesData.items[index].location.address,
                              placesData.items[index].id),
                        )),
        ));
  }
}
