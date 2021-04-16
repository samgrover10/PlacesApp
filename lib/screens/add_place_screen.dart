import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/model/place.dart';
import 'package:places_app/providers/Places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/places_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const route = '/add_places';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  var _titleController = TextEditingController();
  File _pickedImageFile;
  PlaceLocation _pickedLocation;
  var _validate = false;

  void _setImageFile(File pickedImageFile) {
    _pickedImageFile = pickedImageFile;
  }

  void _setPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(lat: latitude, long: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) {
      setState(() {
        _validate = true;
      });
      return;
    } else {
      setState(() {
        _validate = false;
      });
    }

    if (_pickedImageFile == null||_pickedLocation==null) return;
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImageFile,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        errorText: _validate ? 'Title cannot be empty' : null,
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ImageInput(_setImageFile),
                    SizedBox(
                      height: 20,
                    ),
                    PlacesInput(_setPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add place'),
          )
        ],
      ),
    );
  }
}
