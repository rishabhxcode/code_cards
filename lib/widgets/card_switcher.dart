import 'package:code_cards/bloc/favorite/favorite_bloc.dart';
import 'package:code_cards/bloc/known/known_bloc.dart';
import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/back_card.dart';
import 'package:code_cards/widgets/flip_widget.dart';
import 'package:code_cards/widgets/front_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
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
          padding: EdgeInsets.only(bottom: 48, top: 2),
          alignment: Alignment.center,
          key: ValueKey<int>(card.id),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => FavoriteBloc(
                  fav: card.fav,
                  randomCardBloc: context.read<RandomCardsBloc>(),
                ),
              ),
              BlocProvider(
                create: (_) => KnownBloc(
                  isKnown: card.known,
                  randomCardBloc: BlocProvider.of<RandomCardsBloc>(context),
                ),
              )
            ],
            child: FlipWidget(
              flipController: flipController,
              front: FrontCard(
                card: card,
              ),
              back: BackCard(
                card: card,
              ),
            ),
          )),
    );
  }
}
