import 'dart:io';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Person {
  Person({required this.name,  required this.id,required this.country_code, required this.mobile, required this.profile_picture });

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String mobile;

  @HiveField(4)
  String country_code;

  @HiveField(5)
  String profile_picture;

}