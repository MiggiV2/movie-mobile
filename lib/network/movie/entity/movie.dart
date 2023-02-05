class Movie {
  int id;
  int year;
  String name;
  String uuid;
  String block;
  String wikiUrl;
  String type;

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
}
