
class Author {

  int id;
  String login;
  String login_name;
  String full_name;
  String email;
  String avatar_url;
  String language;
  bool is_admin;
  String last_login;
  String created;
  bool restricted;
  bool active;
  bool prohibit_login;
  String location;
  String website;
  String description;
  String visibility;
  int followers_count;
  int following_count;
  int starred_repos_count;
  String username;

	Author.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		login = map["login"],
		login_name = map["login_name"],
		full_name = map["full_name"],
		email = map["email"],
		avatar_url = map["avatar_url"],
		language = map["language"],
		is_admin = map["is_admin"],
		last_login = map["last_login"],
		created = map["created"],
		restricted = map["restricted"],
		active = map["active"],
		prohibit_login = map["prohibit_login"],
		location = map["location"],
		website = map["website"],
		description = map["description"],
		visibility = map["visibility"],
		followers_count = map["followers_count"],
		following_count = map["following_count"],
		starred_repos_count = map["starred_repos_count"],
		username = map["username"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['login'] = login;
		data['login_name'] = login_name;
		data['full_name'] = full_name;
		data['email'] = email;
		data['avatar_url'] = avatar_url;
		data['language'] = language;
		data['is_admin'] = is_admin;
		data['last_login'] = last_login;
		data['created'] = created;
		data['restricted'] = restricted;
		data['active'] = active;
		data['prohibit_login'] = prohibit_login;
		data['location'] = location;
		data['website'] = website;
		data['description'] = description;
		data['visibility'] = visibility;
		data['followers_count'] = followers_count;
		data['following_count'] = following_count;
		data['starred_repos_count'] = starred_repos_count;
		data['username'] = username;
		return data;
	}
}
