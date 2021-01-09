import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
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

class CardListItem extends StatelessWidget {
  final CodeCard card;

  const CardListItem({Key key, this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: -6),
                  backgroundColor: mainColor75,
                  label: Text(
                    card.type,
                    style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: -6),
                  backgroundColor: mainColor15,
                  label: Text(
                    card.tag,
                    style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: mainColor),
                  ),
                ),
                const Spacer(),
                Icon(Icons.star_rounded,
                    color: card.fav ? Colors.yellow[800] : Colors.grey),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              card.question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Divider(),
            Text(card.answer)
          ],
        ),
      ),
    );
  }
}
