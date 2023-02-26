import 'assets.dart';
import 'author.dart';

class Release {

  int id;
  String tag_name;
  String target_commitish;
  String name;
  String body;
  String url;
  String html_url;
  String tarball_url;
  String zipball_url;
  bool draft;
  bool prerelease;
  String created_at;
  String published_at;
  Author author;
  List<Assets> assets;

	Release.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		tag_name = map["tag_name"],
		target_commitish = map["target_commitish"],
		name = map["name"],
		body = map["body"],
		url = map["url"],
		html_url = map["html_url"],
		tarball_url = map["tarball_url"],
		zipball_url = map["zipball_url"],
		draft = map["draft"],
		prerelease = map["prerelease"],
		created_at = map["created_at"],
		published_at = map["published_at"],
		author = Author.fromJsonMap(map["author"]),
		assets = List<Assets>.from(map["assets"].map((it) => Assets.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['tag_name'] = tag_name;
		data['target_commitish'] = target_commitish;
		data['name'] = name;
		data['body'] = body;
		data['url'] = url;
		data['html_url'] = html_url;
		data['tarball_url'] = tarball_url;
		data['zipball_url'] = zipball_url;
		data['draft'] = draft;
		data['prerelease'] = prerelease;
		data['created_at'] = created_at;
		data['published_at'] = published_at;
		data['author'] = author.toJson();
		data['assets'] = assets.map((v) => v.toJson()).toList();
		return data;
	}
}
