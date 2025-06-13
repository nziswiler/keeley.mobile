import 'package:flutter/material.dart';
import 'package:keeley/src/constants/strings.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(Strings.pageNotFound),
    );
  }
}
