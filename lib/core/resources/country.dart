import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tracking_app/core/gen/assets.gen.dart';

class Country {
  String name;
  String code;
  String emoji;
  String unicode;
  String image;

  Country({
    required this.name,
    required this.code,
    required this.emoji,
    required this.unicode,
    required this.image,
  });

  static Future<List<Country>> getSortedCountries() async {
    List<Country> countries = await rootBundle
        .loadString(Assets.files.countries)
        .then((value) {
      final List<dynamic> jsonList = json.decode(value);
      return jsonList.map((json) {
        return Country(
          name: json['name'],
          code: json['code'],
          emoji: json['emoji'],
          unicode: json['unicode'],
          image: json['image'],
        );
      }).toList();
    });

    countries.sort((a, b) => a.name.compareTo(b.name));
    return countries;
  }
}