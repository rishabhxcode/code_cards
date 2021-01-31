import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/helper/database_helper.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final CodeCard card;
  final Widget trailing;

  CardListItem({Key key, this.card, this.trailing}) : super(key: key);

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
                card.tag != null
                    ? Chip(
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
                      )
                    : Container(),
                const Spacer(),
                FavButton(
                  id: card.id,
                  fav: card.fav,
                ),
                // Icon(Icons.star_rounded,
                //     color: card.fav ? Colors.yellow[800] : Colors.grey),
                trailing ?? Container(),
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

class FavButton extends StatefulWidget {
  final int id;
  final bool fav;

  const FavButton({Key key, this.id, this.fav}) : super(key: key);
  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  DatabaseHelper helper = DatabaseHelper();

  bool _isFav;
  @override
  void initState() {
    _isFav = widget.fav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isFav
          ? Icon(
              Icons.star_rounded,
              color: Colors.yellow[800],
            )
          : Icon(
              Icons.star_border_rounded,
              color: Colors.grey[500],
            ),
      onPressed: () async {
        var card = await helper.updateFav(!_isFav, widget.id);
        setState(() {
          _isFav = card.fav;
        });
      },
    );
  }
}
