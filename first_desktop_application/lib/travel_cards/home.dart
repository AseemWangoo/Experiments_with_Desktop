import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(title: const Text('Travel Cards')),
      backgroundColor: const Color(0xff22222b),
      body: const Placeholder(),
    );
  }
}
