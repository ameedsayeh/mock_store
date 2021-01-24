import 'package:flutter/material.dart';
import 'package:mock_store/screens/store_screen/store_screen.dart';

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
