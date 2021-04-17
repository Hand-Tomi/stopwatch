import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final String pageTitle = 'History';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SafeArea(
        child: Text('History Body'),
      ),
    );
  }
}
