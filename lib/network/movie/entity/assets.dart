
class Assets {

  int id;
  String name;
  int size;
  int download_count;
  String created_at;
  String uuid;
  String browser_download_url;

	Assets.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		size = map["size"],
		download_count = map["download_count"],
		created_at = map["created_at"],
		uuid = map["uuid"],
		browser_download_url = map["browser_download_url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['size'] = size;
		data['download_count'] = download_count;
		data['created_at'] = created_at;
		data['uuid'] = uuid;
		data['browser_download_url'] = browser_download_url;
		return data;
	}
}
