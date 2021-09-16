import 'package:flutter/cupertino.dart';

class Character {
  late int charId;
  late String name;
  late List<dynamic> occupation;
  late String image;
  late String statusAliveOrDeath;
  late String nickname;
  late List<dynamic> apperance;
  late String portrayed;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSaulApperance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    occupation = json['occupation'];
    image = json['img'];
    statusAliveOrDeath = json['status'];
    nickname = json['nickname'];
    apperance = json['appearance'];
    //actor name=portrayed
    portrayed = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulApperance = json['better_call_saul_appearance'];
  }
}
