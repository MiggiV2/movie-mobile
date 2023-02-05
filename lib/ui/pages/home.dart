import 'package:flutter/material.dart';
import 'package:movie_mobile/network/login/keycloak_token.dart';

class Home extends StatefulWidget {
  final KeycloakToken token;

  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    if (widget.token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
      debugPrint("Need refresh! ${widget.token.refreshToken}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
