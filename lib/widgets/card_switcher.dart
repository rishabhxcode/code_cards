import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/full_card.dart';
import 'package:flutter/material.dart';

class CardSwitcher extends StatelessWidget {
  final CodeCard card;

  const CardSwitcher({Key key, this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final inAnimation =
            Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);
        final outAnimation =
            Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);
        if (child.key == ValueKey(card.id)) {
          return ClipRect(
            child: SlideTransition(
              position: inAnimation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          );
        } else {
          return ClipRect(
            child: SlideTransition(
              position: outAnimation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          );
        }
      },
      child: FullCard(
        key: key,
        card: card,
      ),
    );
  }
}
