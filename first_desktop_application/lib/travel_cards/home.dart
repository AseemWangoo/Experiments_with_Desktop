import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(title: Text('Travel Cards')),
      backgroundColor: Color(0xff22222b),
      body: Placeholder(),
    );
  }
}
