import 'package:code_cards/model/code_card.dart';
import 'package:flutter/material.dart';

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
                    child: Text('code',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic)),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.grey[500],
                  )
                ],
              ),
              const Spacer(),
              Text(
                card.answer,
                style: TextStyle(fontSize: 24),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}
