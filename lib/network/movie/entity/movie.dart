import 'dart:convert';

import 'package:crypto/crypto.dart';

class Movie {
  int id;
  int year;
  String name;
  String uuid;
  String block;
  String wikiUrl;
  String type;

  Movie(this.id, this.year, this.name, this.uuid, this.block, this.wikiUrl,
      this.type);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        year = json['year'],
        name = json['name'],
        uuid = json['uuid'],
        block = json['block'],
        wikiUrl = json['wikiUrl'],
        type = json['type'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['name'] = name;
    data['uuid'] = uuid;
    data['block'] = block;
    data['wikiUrl'] = wikiUrl;
    data['type'] = type;
    return data;
  }

  String getHash() {
    String input =
        "year:$year,name:$name,uuid:$uuid,block:$block,wikiUrl:$wikiUrl,type:$type";
    return md5.convert(utf8.encode(input)).toString();
  }
}
