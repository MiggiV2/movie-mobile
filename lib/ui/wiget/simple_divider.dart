import 'package:flutter/material.dart';

class SimpleDivider extends StatelessWidget {
  const SimpleDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Theme.of(context).colorScheme.onBackground,
        height: 0,
        thickness: 1,
      ),
    );
  }
}
