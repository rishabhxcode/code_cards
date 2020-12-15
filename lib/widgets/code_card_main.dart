import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/full_card.dart';
import 'package:flutter/material.dart';

class CodeCardMain extends StatelessWidget {
  final CodeCard card;
  const CodeCardMain({Key key, this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FullCard(
      card: card,
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
