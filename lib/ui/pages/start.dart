import 'package:flutter/material.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/ui/pages/home.dart';
import 'package:movie_mobile/ui/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    loadToken();
    super.initState();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    KeycloakToken localTokens = KeycloakToken();
    setState(() {
      localTokens.accessToken = prefs.getString('access_token') ?? "";
      localTokens.refreshToken = prefs.getString('refresh_token') ?? "";
      localTokens.expiresIn = prefs.getInt('expires') ?? 0;
      localTokens.refreshExpiresIn = prefs.getInt('refresh_expires') ?? 0;

      openPage(localTokens);
    });
  }

  void openPage(KeycloakToken localTokens) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        if (localTokens.refreshExpiresIn <
            DateTime.now().millisecondsSinceEpoch) {
          return const Login();
        }
        return Home(
          token: localTokens,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
