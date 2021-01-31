import 'package:code_cards/bloc/random_cards/random_cards_bloc.dart';
import 'package:code_cards/constants/theme_constants.dart';
import 'package:code_cards/model/code_card.dart';
import 'package:code_cards/widgets/card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullCard extends StatefulWidget {
  final CodeCard card;
  const FullCard({Key key, this.card}) : super(key: key);
  @override
  _FullCardState createState() => _FullCardState();
}

class _FullCardState extends State<FullCard>
    with SingleTickerProviderStateMixin {
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
        Expanded(
          flex: 4,
          child: CardSwitcher(
            card: widget.card,
            flipController: _flipController,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.topCenter,
            child: BottomButtonBar(
              onFlip: () {
                _flipController.isDismissed
                    ? _flipController.forward()
                    : _flipController.reverse();
              },
              onNext: () {
                if (_flipController.isCompleted) {
                  _flipController.reverse();
                }
                context.read<RandomCardsBloc>().add(LoadNextRandomCard());
              },
            ),
          ),
        )
      ],
    );
  }
}

class BottomButtonBar extends StatelessWidget {
  final Function onFlip;
  final Function onNext;

  const BottomButtonBar({Key key, this.onFlip, this.onNext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlineButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            borderSide: BorderSide(color: mainColor),
            onPressed: onFlip,
            icon: const Icon(Icons.swap_horiz_rounded, color: mainColor),
            label: Text(
              'FLIP',
              style: TextStyle(color: mainColor),
            )),
        const SizedBox(
          width: 50,
        ),
        FlatButton(
          color: mainColor,
          onPressed: onNext,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    );
  }
}
