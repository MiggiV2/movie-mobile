import 'package:flutter/material.dart';
import 'package:movie_mobile/network/auth/login.dart';
import 'package:movie_mobile/ui/pages/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "", password = "";
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movie - Login",
          style: TextStyle(fontFamily: "Roboto-Bold", fontSize: 21),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: buildInputForm(),
            ),
          ],
        ),
      ),
    );
  }

  Column buildInputForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                hintText: "Username",
                contentPadding: EdgeInsets.all(8),
                suffixIcon: Icon(Icons.person)),
            onChanged: (value) {
              setState(() {
                username = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: isObscureText,
              decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: InkWell(
                    child: isObscureText
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.remove_red_eye_outlined),
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ElevatedButton(
            onPressed: _onLogin,
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                textStyle: const TextStyle(fontSize: 22)),
            child: const Text("Login"),
          ),
        )
      ],
    );
  }

  void _onLogin() {
    login(username, password)
        .then((token) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(token: token),
            )))
        .catchError(handleError);
  }

  handleError(e) {
    debugPrint(e.toString());
    String msg = "Error";
    if (e.toString().startsWith("Failed host lookup: ")) {
      msg = "Check your internet. (DNS)";
    } else {
      msg = e.toString().replaceFirst("Exception: ", "");
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
