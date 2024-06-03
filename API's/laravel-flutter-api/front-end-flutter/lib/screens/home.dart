import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Logged in'),
        ),
        body: Center(
          child: Text('Welcome', style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
