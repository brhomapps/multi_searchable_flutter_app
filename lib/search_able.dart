import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Searchable {
  String? label;
  ValueNotifier<bool>? isSelected;

  Searchable({this.label, this.isSelected});
}
