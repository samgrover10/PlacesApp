import 'package:flutter/material.dart';
import 'package:places_app/providers/Places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (_)=>Places(),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        home:PlacesListScreen(),
        routes: {
          AddPlaceScreen.route:(_)=>AddPlaceScreen(),
          PlaceDetailScreen.route:(_)=>PlaceDetailScreen()
        },
      ),
    );
  }
}
