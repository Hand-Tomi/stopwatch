import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   child: Text('Drawer Header'),
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          // ),
          ListTile(
            title: Text('Licenses'),
            onTap: () => showLicensePage(context: context),
          ),
          // ListTile(
          //   title: Text('Item 2'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
        ],
      ),
    );
  }
}
