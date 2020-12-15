import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/provider/question_repo/question_repository.dart';
import 'package:code_cards/widgets/back_card.dart';
import 'package:code_cards/widgets/flip_widget.dart';
import 'package:code_cards/widgets/front_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FullCard extends StatefulWidget {
  final CodeCard card;
  const FullCard({Key key, this.card}) : super(key: key);
  @override
  _FullCardState createState() => _FullCardState();
}

class _FullCardState extends State<FullCard>
    with SingleTickerProviderStateMixin {
  QuestionRepo questionRepo = QuestionRepo();

  AnimationController _flipController;
  @override
  void initState() {
    _flipController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlipWidget(
          flipController: _flipController,
          front: FrontCard(
            card: widget.card,
          ),
          back: BackCard(
            card: widget.card,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                borderSide: BorderSide(color: Colors.deepPurple),
                onPressed: () {
                  _flipController.isDismissed
                      ? _flipController.forward()
                      : _flipController.reverse();
                },
                icon: Icon(Icons.swap_horiz_rounded, color: Colors.deepPurple),
                label: Text(
                  'FLIP',
                  style: TextStyle(color: Colors.deepPurple),
                )),
            const SizedBox(
              width: 50,
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text(
                    'Next Card',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
