import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:flutter/material.dart';

import 'favorite_widget.dart';

class BackCard extends StatelessWidget {
  final CodeCard card;
  const BackCard({Key key, this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    ' Answer',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: mainColor50),
                  ),
                  const Spacer(),
                  FavoriteButton(
                    id: card.id,
                    fav: card.fav,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: AutoSizeText(
                        card.answer,
                        maxLines: 10,
                        minFontSize: 16,
                        maxFontSize: 24,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
