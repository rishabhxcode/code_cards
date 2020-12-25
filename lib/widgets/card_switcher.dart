import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/back_card.dart';
import 'package:code_cards/widgets/flip_widget.dart';
import 'package:code_cards/widgets/front_card.dart';
import 'package:flutter/cupertino.dart';

class CardSwitcher extends StatelessWidget {
  final AnimationController flipController;
  final CodeCard card;
  CardSwitcher({this.flipController, this.card});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final outAnimation =
            Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                .chain(CurveTween(curve: Curves.easeInCubic))
                .animate(animation);
        final inAnimation =
            Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .chain(CurveTween(curve: Curves.easeOutCubic))
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
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical:36),
        alignment: Alignment.center,
        key: ValueKey<int>(card.id),
        child: FlipWidget(
          flipController: flipController,
          front: FrontCard(
            card: card,
          ),
          back: BackCard(
            card: card,
          ),
        ),
      ),
    );
  }
}
