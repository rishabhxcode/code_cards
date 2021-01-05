import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/favorite_widget.dart';
import 'package:flutter/material.dart';

class FrontCard extends StatelessWidget {
  final CodeCard card;
  const FrontCard({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 400,
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.cyan[50],
                        border:
                            Border.all(width: 0.5, color: Colors.grey[400])),
                    child: Text('general',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  const Spacer(),
                  FavoriteButton(
                    id: card.id,
                    fav: card.star,
                  )
                ],
              ),
              const Spacer(),
              Text(
                card.question,
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
              DoYouKnowThisWidget(),
              const SizedBox(
                height: 24,
              )
            ],
          )),
    );
  }
}

class DoYouKnowThisWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Do you know this?',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.green,
              onPressed: () {},
              child: Text('YES',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              width: 24,
            ),
            FlatButton(
                color: Colors.red,
                onPressed: () {},
                child: Text('NO',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)))
          ],
        )
      ],
    );
  }
}
