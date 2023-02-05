import 'package:flutter/material.dart';
import 'package:movie_mobile/ui/pages/start.dart';

import 'ui/color_schemes.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: "Roboto"),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          fontFamily: "Roboto"),
      home: const Start(),
    ));
