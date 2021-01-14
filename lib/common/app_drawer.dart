import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/screens/favorite_cards_list_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              height: 100,
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                'Code Cards',
                style: TextStyle(fontSize: 24),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey)))),
          ListTile(
            leading: Icon(
              Icons.star_rounded,
              color: Colors.yellow[800],
            ),
            title: Text('Favorites'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, FavoriteCardsListScreen.routeName);
            },
          ),
          ListTile(
              leading: Icon(
                Icons.web_asset_rounded,
                color: Colors.deepOrange,
              ),
              title: Text('My Questions'),
              onTap: () {}),
          ListTile(
              leading: Icon(
                Icons.show_chart_outlined,
                color: Colors.green,
              ),
              title: Text('Statistics'),
              onTap: () {}),
          ListTile(
              leading: Icon(
                Icons.share_rounded,
                color: Colors.blue,
              ),
              title: Text(
                'Share',
              ),
              onTap: () {}),
          ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                color: mainColor,
              ),
              title: Text('About'),
              onTap: () {}),
        ],
      ),
    );
  }
}
