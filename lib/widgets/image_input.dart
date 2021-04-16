import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function _setImageFile;
  ImageInput(this._setImageFile);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imgSelected;
  Future<void> _captureImage() async {
    final pickedImg =
        await ImagePicker().getImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImg==null) return;
    setState(() {
      _imgSelected = File(pickedImg.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(pickedImg.path);
    final savedImage = await _imgSelected.copy('${appDir.path}/$filename');
    widget._setImageFile(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: _imgSelected != null
            ? Image.file(
                _imgSelected,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text('Select an image'),
        alignment: Alignment.center,
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
          child: TextButton.icon(
              onPressed: _captureImage,
              icon: Icon(Icons.camera),
              label: Text('Take picture'))),
    ]);
  }
}
