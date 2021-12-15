import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages.dart';
import 'search_item.dart';

List<SearchItems> getSearch() {
  /// put items of list view here ///
  return [
    SearchItems(
        'Yemen', Image.asset('assets/yemen.png', fit: BoxFit.cover), Yemen()),
    SearchItems(
        'Egypt', Image.asset('assets/egypt.png', fit: BoxFit.cover), Egypt()),
    SearchItems('Tunisia', Image.asset('assets/tunisia.png', fit: BoxFit.cover),
        Tunisia()),
    SearchItems('Algeria', Image.asset('assets/algeria.png', fit: BoxFit.cover),
        Algeria()),
    SearchItems(
        'Iraq', Image.asset('assets/iraq.png', fit: BoxFit.cover), Iraq()),
    SearchItems(
        'Saudi Arabia',
        Image.asset('assets/saudi arabia.png', fit: BoxFit.cover),
        SaudiArabia()),
    SearchItems('Jordan', Image.asset('assets/jordan.png', fit: BoxFit.cover),
        Jordan()),
    SearchItems(
        'Syria', Image.asset('assets/syria.png', fit: BoxFit.cover), Syria()),
  ];
}
