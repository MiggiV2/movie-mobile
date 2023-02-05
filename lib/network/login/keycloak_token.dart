class KeycloakToken {
  String accessToken;
  int expiresIn;
  int refreshExpiresIn;
  String refreshToken;
  String tokenType;
  Object idToken;
  int notBeforePolicy;
  String seasonState;
  String scope;

  KeycloakToken()
      : accessToken = "",
        expiresIn = 0,
        refreshExpiresIn = 0,
        refreshToken = "",
        tokenType = "",
        idToken = "",
        notBeforePolicy = 0,
        seasonState = "",
        scope = "";

  KeycloakToken.fromJsonMap(Map<String, dynamic> map)
      : accessToken = map["accessToken"],
        expiresIn = map["expiresIn"],
        refreshExpiresIn = map["refreshExpiresIn"],
        refreshToken = map["refreshToken"],
        tokenType = map["tokenType"],
        idToken = map["idToken"] ?? "",
        notBeforePolicy = map["notBeforePolicy"],
        seasonState = map["seasonState"],
        scope = map["scope"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = accessToken;
    data['expiresIn'] = expiresIn;
    data['refreshExpiresIn'] = refreshExpiresIn;
    data['refreshToken'] = refreshToken;
    data['tokenType'] = tokenType;
    data['idToken'] = idToken;
    data['notBeforePolicy'] = notBeforePolicy;
    data['seasonState'] = seasonState;
    data['scope'] = scope;
    return data;
  }
}
