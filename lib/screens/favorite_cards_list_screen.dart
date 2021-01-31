import 'package:code_cards/common/card_list_item.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:flutter/material.dart';

class FavoriteCardsListScreen extends StatelessWidget {
  static final String routeName = '/favorite_cards_list_screen';
  DatabaseHelper helper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.yellow[800],
              ),
              const SizedBox(
                width: 12,
              ),
              Text('Favorites', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        body: FutureBuilder(
            future: helper.loadFavorites(),
            builder: (context, snap) {
              if (snap.hasData) {
                return snap.data.length != 0
                    ? ListView.builder(
                        itemCount: snap.data.length,
                        itemBuilder: (context, index) {
                          return CardListItem(
                            card: snap.data[index],
                          );
                        })
                    : Center(
                        child: Text('No favorites yet!'),
                      );
              } else {
                return Center(
                  child: Text('Something went wrong'),
                );
              }
            }));
  }
}
