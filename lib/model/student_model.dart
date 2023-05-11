import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Student {
  String? name;
  String? hero;
  String? description;

  Student({required this.name, required this.hero, required this.description});

  Student.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        hero = json['hero'],
        description = json['description'];

  Student.toJson(Map<String, dynamic> json) {
    json['name'] = name;
    json['hero'] = hero;

    json['description'] = description;
  }
}
