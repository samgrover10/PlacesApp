import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/screens/place_details_screen.dart';

class PlaceItem extends StatelessWidget {
  final String title;
  final File imgFile;
  final String address;
  final String id;
  PlaceItem(this.imgFile, this.title, this.address,this.id);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          onTap: ()=> Navigator.of(context).pushNamed(PlaceDetailScreen.route,arguments: id),
          leading: Hero(tag: id,child: CircleAvatar(backgroundImage: FileImage(imgFile))),
          title: Text(title),
          subtitle: Text(address),
          trailing: IconButton(
            color: Theme.of(context).errorColor,
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
