import 'package:flutter/material.dart';

class PageModel {
  String _title;
  String _description;
  String _image;

  PageModel(this._title, this._description, this._image);

  String get image => _image;

  String get description => _description;

  String get title => _title;
}
